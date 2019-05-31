class CashMovementsController < ApplicationController

  def index
    @cash_movements = CashMovement.all
  end

  def get_invoices
    if params[:val].present?
      @invoices = SalesInvoice.find_by_client(params[:val])
      respond_to do |format|
        format.js
      end
    end
  end

  def new
    @cash_movement = CashMovement.new
    @cash_movement_values =  @cash_movement.cash_movement_values.build
  end

  def create
    CashMovement.transaction do
      @cash_movement = CashMovement.new(cash_movement_params)
      @cash_movement.save
      #actualizar saldos de facturas a 0 (solo pago al contado)
      SalesInvoice.where(id: params[:invoices_ids]).update_all(balance: 0)
      #facturas cobradas en el movimiento
      params[:invoices_ids].each do |invoice|
        @cash_movement_invoice = CashMovementInvoice.new
        @cash_movement_invoice.cash_movement_id = @cash_movement.id
        @cash_movement_invoice.sales_invoice_id = invoice
        @cash_movement_invoice.save
      end

    end
  end

  def show
  end

  #Obtener facturas de un cliente por medio de su id
  def cash_movement_params
    params.require(:cash_movement).permit(:date, :comments, :total, :client_id, :cash_id, cash_movement_values_attributes: [:id, :ammount, :pay_method_id, :card_number, :bank_id, :drawer, :account_number, :check_number, :emission_date, :due_date])
  end
end
