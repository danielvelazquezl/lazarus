class PurchaseInvoicesController < ApplicationController
  before_action :set_purchase_invoice, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /purchase_invoices
  # GET /purchase_invoices.json
  def index
    (@filterrific = initialize_filterrific(
        PurchaseInvoice,
        params[:filterrific],
        select_options: {
            sorted_by: PurchaseInvoice.options_for_sorted_by
        },
        )) || return
    @purchase_invoices = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /purchase_invoices/1
  # GET /purchase_invoices/1.json
  def show
  end

  # GET /purchase_invoices/new
  def new
    @purchase_invoice = PurchaseInvoice.new
    if params[:note_number].present? then
      purchaseOrder = PurchaseOrder.find_by(number: params[:note_number])
      if purchaseOrder != nil && purchaseOrder.state == :received
        @purchaseOrder_items = PurchaseOrderItem.where(purchase_order_id: purchaseOrder.id)
        @purchase_invoice.provider_id = purchaseOrder.provider_id
        @purchase_invoice.employee_id = purchaseOrder.employee_id
        @purchase_invoice.deposit_id = Setting.find_by!(key: 'id_components_deposit').value
        @purchase_invoice.purchase_order_id = purchaseOrder.id
        @purchase_invoice.date = Time.now

        @purchaseOrder_items.each do |item|
          @purchase_invoice.purchase_invoice_items.build(product_id: item.product_id,
                                                    quantity: item.requested_quantity,
                                                    price: item.price,
                                                    sub_total: item.requested_quantity * item.product.unit_cost,
                                                    iva: (item.requested_quantity * item.product.unit_cost) / 11)
        end

      else
        respond_to do |format|
          format.html {redirect_to new_purchase_invoice_path, alert: 'Orden de compra no encontrada.'}
          format.json {render json: @purchase_invoice.errors, status: :unprocessable_entity}
        end
      end
    end
  end

  # GET /purchase_invoices/1/edit
  def edit
  end

  # POST /purchase_invoices
  # POST /purchase_invoices.json
  def create
    @purchase_invoice = PurchaseInvoice.new(purchase_invoice_params)
    @purchase_invoice.purchase_invoice_items.each do |f|
      f.sub_total = f.price * f.quantity
      f.iva = f.sub_total / 11
      @purchase_invoice.increment(:total, f.sub_total)
      @purchase_invoice.increment(:iva, f.iva)
    end
    @purchase_invoice.balance = @purchase_invoice.total

    respond_to do |format|
      if @purchase_invoice.save
        @purchase_invoice_items = @purchase_invoice.purchase_invoice_items
        @purchase_invoice_items.each do |item|
          product = Product.find_by(id: item.product.id)
          product.update_attribute(:unit_cost, item.price)
        end

        purchase_order = PurchaseOrder.find_by(number: @purchase_invoice.purchase_order.number)
        purchase_order.update_attribute(:state, PurchaseOrder.state.invoiced)

        format.html { redirect_to purchase_invoices_path, notice: 'Factura creada.' }
        format.json { render :show, status: :created, location: @purchase_invoice }
      else
        format.html { render :new }
        format.json { render json: @purchase_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_invoices/1
  # PATCH/PUT /purchase_invoices/1.json
  def update
    respond_to do |format|
      if @purchase_invoice.update(purchase_invoice_params)
        format.html { redirect_to @purchase_invoice, notice: 'Purchase invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_invoice }
      else
        format.html { render :edit }
        format.json { render json: @purchase_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_invoices/1
  # DELETE /purchase_invoices/1.json
  def destroy
    @purchase_invoice.destroy
    respond_to do |format|
      format.html { redirect_to purchase_invoices_url, notice: 'Purchase invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_purchase_invoice
    @purchase_invoice = PurchaseInvoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def purchase_invoice_params
    params.require(:purchase_invoice).permit(:provider_id, :employee_id, :date, :total, :iva, :balance, :invoice_number, :stamped, :deposit_id, :purchase_order_id,  purchase_invoice_items_attributes: [:id, :product_id, :quantity, :price, :iva, :sub_total])
  end
end
