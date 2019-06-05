class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy]

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    @purchase_orders = PurchaseOrder.all
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show
  end

  # GET /purchase_orders/new
  def new
    @purchase_order = PurchaseOrder.new
    if params[:request_number].present? then
      @purchaseRqst = PurchaseRequest.find_by(number: params[:request_number])
      if @purchaseRqst != nil
        @purchase_order.state = :created
        @budget_items = BudgetRequest.get_cheapest_items(@purchaseRqst)
      else
        respond_to do |format|
          format.html {redirect_to new_purchase_order_path, alert: 'Pedido de compra no encontrada.'}
          format.json {render json: @purchase_order.errors, status: :unprocessable_entity}
        end
      end

    end
  end

  # GET /purchase_orders/1/edit
  def edit
  end

  # POST /purchase_orders
  # POST /purchase_orders.json
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    respond_to do |format|
      if @purchase_order.save
        format.html { redirect_to @purchase_order, notice: 'Purchase order was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_order }
      else
        format.html { render :new }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def save_purchase_orders
    purchaseRqst = PurchaseRequest.find_by(number: params[:request_number])
    budget_items = BudgetRequest.get_cheapest_items(purchaseRqst)
    PurchaseOrder.create_purchase_order(budget_items)
    respond_to do |format|
      format.html {redirect_to purchase_orders_path, notice: 'Ordenes creadas.'}
    end
  end

  # PATCH/PUT /purchase_orders/1
  # PATCH/PUT /purchase_orders/1.json
  def update
    respond_to do |format|
      if @purchase_order.update(purchase_order_params)
        format.html { redirect_to edit_purchase_order_path, notice: 'Orden de compra actualizada' }
        format.json { render :show, status: :ok, location: @purchase_order }
      else
        format.html { render :edit }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.json
  def destroy
    @purchase_order.destroy
    respond_to do |format|
      format.html { redirect_to purchase_orders_url, notice: 'Purchase order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_params
      params.require(:purchase_order).permit(:provider_id, :employee_id, :date, :state, :comment, :number, purchase_order_items_attributes: [:id, :purchase_order_id, :product_id, :price, :requested_quantity, :received_quantity])
    end
end
