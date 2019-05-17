class CashMovementsController < ApplicationController

  def index
    @cash_movement = CashMovement.new
    if params[:val].present?
      @invoices = SalesInvoice.find_by_client(params[:val])
      respond_to do |format|
        format.js
      end
    end
  end

  def new
    #@cash_movement = CashMovement.new
  end

  def pay_invoices
    #actualizar saldos de las facturas cobradas
    SalesInvoice.where(id: params[:invoices_ids]).update_all(balance: 0)
    if params[:client_id].present?
      @cash_movement = CashMovement.new
      #anidado con cash_movement_value
      #@cash_movement_values = @cash_movement.cash_cash_movement_values.build
      #@pay_methods_values = @cash_movement.pay_methods_values.build
      #movimiento de caja
      @cash_movement.client_id = params[:client_id]
      #fecha,observacion y total
      @cash_movement.date = params[:date]
      @cash_movement.comments = params[:comments]
      @cash_movement.total = params[:total]
      @cash_movement.save

      #facturas cobradas en el movimiento
      params[:invoices_ids].each do |invoice|
        @cash_movement_invoice = CashMovementInvoice.new

        @cash_movement_invoice.cash_id = @cash_movement.id
        @cash_movement_invoice.ammount = SalesInvoice.find(invoice).total
        @cash_movement_invoice.save
      end

      #detalles del cash_movement
      #@cash_movement_value = CashMovementValue.new
      #@cash_movement_value.cash_id = @cash_movement.id
      #@cash_movement_value.ammount quitar total de text field
    end
  end

  #Obtener facturas de un cliente por medio de su id
  def cash_movement_params
    params.require(:cash_movement).permit(:date, :comments, :total, :client_id, cash_cash_movement_values: [:id, :cash_id, :ammount, :payment_id])
  end
end
