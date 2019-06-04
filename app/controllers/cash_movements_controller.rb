class CashMovementsController < ApplicationController
  before_action :set_cash_movement, only: [:show]
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

  def show
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
      #SalesInvoice.where(id: params[:invoices_ids]).update_all(balance: 0)
      SalesInvoice.update_invoices_balance(params[:invoices_ids],0)
      #facturas cobradas en el movimiento
      params[:invoices_ids].each do |invoice|
        @cash_movement_invoice = CashMovementInvoice.new
        @cash_movement_invoice.cash_movement_id = @cash_movement.id
        @cash_movement_invoice.sales_invoice_id = invoice
        @cash_movement_invoice.save
      end

    end
    respond_to do |format|
      format.html { redirect_to @cash_movement, notice: 'Movimiento creado.' }
    end
  end


  #Obtener facturas de un cliente por medio de su id
  def cash_movement_params
    params.require(:cash_movement).permit(:date, :comments, :total, :client_id, :cash_id, cash_movement_values_attributes: [:id, :ammount, :pay_method_id, :card_number, :bank_id, :drawer, :account_number, :check_number, :emission_date, :due_date])
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_cash_movement
    @cash_movement = CashMovement.find(params[:id])
    @cash_movement_values = CashMovementValue.find_by_cash_mov(params[:id])

  end
end
