class CashMovementsController < ApplicationController
  before_action :set_cash_movement, only: [:show]
  #load_and_authorize_resource

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
    @open_cashes = Cash.all_open
  end

  def create
    CashMovement.transaction do
      @cash_movement = CashMovement.new(cash_movement_params)
      @cash_movement.save
      #Suponiendo que 1 es efectivo, 2 cheque, 3 tarjeta credito

      total_bill = OpenCloseCash.amount_open_cashes_bill(@cash_movement.cash_id)
      total_check = OpenCloseCash.amount_open_cashes_check(@cash_movement.cash_id)
      total_card = OpenCloseCash.amount_open_cashes_card(@cash_movement.cash_id)



      total_bill += CashMovementValue.find_cash_mov_total_by_pay_method(@cash_movement.id,1)
      total_check += CashMovementValue.find_cash_mov_total_by_pay_method(@cash_movement.id,2)
      total_card += CashMovementValue.find_cash_mov_total_by_pay_method(@cash_movement.id,3)

      total_mov = total_bill + total_check + total_card

      OpenCloseCash.update_open_cashes_bill(@cash_movement.cash_id,total_bill)
      OpenCloseCash.update_open_cashes_check(@cash_movement.cash_id,total_check)
      OpenCloseCash.update_open_cashes_card(@cash_movement.cash_id,total_card)
     #se actualiza monto para hacer conciliacion
      OpenCloseCash.update_open_cash_final_ammount(@cash_movement.cash_id,total_mov)
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
    @cash_movement_invoices =  CashMovementInvoice.find_by_cash_mov(params[:id])
  end
end
