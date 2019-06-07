class BudgetRequestsController < ApplicationController
  before_action :set_budget_request, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /budget_requests
  # GET /budget_requests.json
  def index
    (@filterrific = initialize_filterrific(
        BudgetRequest,
        params[:filterrific],
        select_options: {
            sorted_by: BudgetRequest.options_for_sorted_by
        },
        )) || return
    @budget_requests = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /budget_requests/1
  # GET /budget_requests/1.json
  def show
  end

  # GET /budget_requests/new
  def new
    @budget_request = BudgetRequest.new
  end

  # GET /budget_requests/1/edit
  def edit
  end

  # POST /budget_requests
  # POST /budget_requests.json
  def create
    @budget_request = BudgetRequest.new(budget_request_params)

    respond_to do |format|
      if @budget_request.save
        purchase = @budget_request.purchase_request_id
        format.html { redirect_to edit_purchase_request_path(PurchaseRequest.find_by(id: purchase)), notice: 'Pedido de cotización actualizado.' }
        format.json { render :show, status: :created, location: @budget_request }
      else
        format.html { render :new }
        format.json { render json: @budget_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budget_requests/1
  # PATCH/PUT /budget_requests/1.json
  def update
    respond_to do |format|
      if @budget_request.update(budget_request_params)
        budget_request = BudgetRequest.find_by(id: @budget_request.id)
        budget_request.update_attribute(:state, BudgetRequest.state.finished)
        format.html {redirect_to edit_budget_request_path, notice: 'Pedido de Cotización actualizada.'}
        format.json {render :show, status: :ok, location: @order}
      else
        format.html { render :edit }
        format.json { render json: @budget_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budget_requests/1
  # DELETE /budget_requests/1.json
  def destroy
    @budget_request.destroy
    respond_to do |format|
      format.html { redirect_to budget_requests_url, notice: 'Budget request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget_request
      @budget_request = BudgetRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_request_params
      params.require(:budget_request).permit(:provider_id, :employee_id, :date, :state, :comment, :purchase_request_id, budget_request_items_attributes: [:id, :product_id, :price, :requested_quantity, :pending_quantity])
    end
end
