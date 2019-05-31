class SalesInvoicesController < ApplicationController
  before_action :set_sales_invoice, only: [:show, :edit, :update, :destroy]

  # GET /sales_invoices
  # GET /sales_invoices.json
  def index
    @sales_invoices = SalesInvoice.all
  end

  # GET /sales_invoices/1
  # GET /sales_invoices/1.json
  def show
  end

  # GET /sales_invoices/new
  def new
    @sales_invoice = SalesInvoice.new
    if params[:note_number].present? then
      orderTicket = OrderTicket.find_by(ticket_number: params[:note_number])
      @stampeds = Stamped.all
      if orderTicket != nil
        @orderTicket_items = OrderTicketItem.where(order_ticket_id: orderTicket.id)
        @sales_invoice.client_id = orderTicket.client_id
        @sales_invoice.employee_id = orderTicket.employee_id
        @sales_invoice.deposit_id = Setting.find_by!(key: 'id_products_deposit').value
        @sales_invoice.order_ticket_id = orderTicket.id
        @sales_invoice.pay_method_id = orderTicket.pay_method_id
        @sales_invoice.date = Time.now
        @sales_invoice.invoice_number = Setting.find_by(key: "nextInvoices").value
        @sales_invoice.stamped_id = Setting.find_by(key: "default_stamped").value

        @orderTicket_items.each do |item|
          @sales_invoice.sales_invoices_items.build(product_id: item.product_id,
                                                    quantity: item.request_quantity,
                                                    price: item.product.unit_cost,
                                                    sub_total: item.request_quantity * item.product.unit_cost,
                                                    iva: (item.request_quantity * item.product.unit_cost) / 11)
        end

      else
        respond_to do |format|
          format.html {redirect_to new_sales_invoice_path, notice: 'Nota de pedido no encontrada.'}
          format.json {render json: @sales_invoice.errors, status: :unprocessable_entity}
        end
      end

    end

  end

  # GET /sales_invoices/1/edit
  def edit
    @stampeds = Stamped.all
  end

  # POST /sales_invoices
  # POST /sales_invoices.json
  def create
    @sales_invoice = SalesInvoice.new(sales_invoice_params)
    @sales_invoice.sales_invoices_items.each do |f|
      f.sub_total = f.price * f.quantity
      f.iva = f.sub_total / 11
      @sales_invoice.increment(:total, f.sub_total)
      @sales_invoice.increment(:iva, f.iva)
    end
    @sales_invoice.balance = @sales_invoice.total
    nex = Setting.find_by(key: "nextInvoices")
    Setting.update(nex.id, :value => (@sales_invoice.invoice_number + 1))

    respond_to do |format|
      if @sales_invoice.save
        order_ticket = OrderTicket.find_by(ticket_number: @sales_invoice.order_ticket.ticket_number)
        order_ticket.update_attribute(:state, OrderTicket.state.invoiced)
        format.html {redirect_to sales_invoices_path, notice: 'Factura creada.'}
        format.json {render :index, status: :created, location: @sales_invoice}
      else
        format.html {render :new}
        format.json {render json: @sales_invoice.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /sales_invoices/1
  # PATCH/PUT /sales_invoices/1.json
  def update
    respond_to do |format|
      if @sales_invoice.update(sales_invoice_params)
        format.html {redirect_to @sales_invoice, notice: 'Sales invoice was successfully updated.'}
        format.json {render :show, status: :ok, location: @sales_invoice}
      else
        format.html {render :edit}
        format.json {render json: @sales_invoice.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /sales_invoices/1
  # DELETE /sales_invoices/1.json
  def destroy
    @sales_invoice.destroy
    respond_to do |format|
      format.html {redirect_to sales_invoices_url, notice: 'Sales invoice was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sales_invoice
    @sales_invoice = SalesInvoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sales_invoice_params
    params.require(:sales_invoice).permit(:employee_id, :date, :client_id, :total, :iva, :balance, :invoice_number, :stamped_id, :deposit_id, :pay_method_id, :order_ticket_id, sales_invoices_items_attributes: [:id, :product_id, :quantity, :price, :iva, :sub_total])
  end
end
