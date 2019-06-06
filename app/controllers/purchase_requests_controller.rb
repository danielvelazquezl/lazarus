class PurchaseRequestsController < ApplicationController
  before_action :set_purchase_request, only: [:show, :edit, :update, :destroy]

  # GET /purchase_requests
  # GET /purchase_requests.json
  def index
    (@filterrific = initialize_filterrific(
      PurchaseRequest,
      params[:filterrific],
      select_options: {
          sorted_by: PurchaseRequest.options_for_sorted_by
      },
      )) || return
    @purchase_requests = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /purchase_requests/1
  # GET /purchase_requests/1.json
  def show
  end

  # GET /purchase_requests/new
  def new
    @purchase_request = PurchaseRequest.new
    @purchase_request_items = @purchase_request.purchase_request_items.build
  end

  # GET /purchase_requests/1/edit
  def edit
    @budget = BudgetRequest.find_by(purchase_request_id: params[:id])
    if @budget != nil
      @budget_request = BudgetRequest.where(purchase_request_id: params[:id])
    end
  end

  # POST /purchase_requests
  # POST /purchase_requests.json
  def create
    @purchase_request = PurchaseRequest.new(purchase_request_params)

    respond_to do |format|
      if @purchase_request.save
        format.html { redirect_to edit_purchase_request_path, notice: 'Purchase request was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_request }
      else
        format.html { render :new }
        format.json { render json: @purchase_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_requests/1
  # PATCH/PUT /purchase_requests/1.json
  def update
    respond_to do |format|
      if @purchase_request.update(purchase_request_params)
        purchase_request = PurchaseRequest.find_by(id: @purchase_request.id)
        purchase_request.update_attribute(:state, PurchaseRequest.state.generated)
        format.html { redirect_to edit_purchase_request_path, notice: 'Cotizaciones generadas.' }
        format.json { render :show, status: :ok, location: @purchase_request }
      else
        format.html { render :edit }
        format.json { render json: @purchase_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_requests/1
  # DELETE /purchase_requests/1.json
  def destroy
    @purchase_request.destroy
    respond_to do |format|
      format.html { redirect_to purchase_requests_url, notice: 'Purchase request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_request
      @purchase_request = PurchaseRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_request_params
      params.require(:purchase_request).permit(:date, :employee_id, :state, :comment, :number, purchase_request_items_attributes: [:id, :purchase_request_id, :product_id, :quantity])
    end
end
