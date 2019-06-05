class OrderTicketsController < ApplicationController
  before_action :set_order_ticket, only: [:show, :edit, :update, :destroy]

  # GET /order_tickets
  # GET /order_tickets.json
  def index
    (@filterrific = initialize_filterrific(
      OrderTicket,
      params[:filterrific],
      select_options: {
          sorted_by: OrderTicket.options_for_sorted_by
      },
      )) || return
    @order_tickets = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /order_tickets/1
  # GET /order_tickets/1.json
  def show
  end

  # GET /order_tickets/new
  def new
    @order_ticket = OrderTicket.new
    @order_ticket.date = Time.now
    @order_ticket.state = :uninvoiced
    orderLast = @order_ticket.ticket_number = OrderTicket.find_by(ticket_number: 1)
    if orderLast != nil
      @order_ticket.ticket_number = OrderTicket.order("updated_at").last().ticket_number + 1
    else
      @order_ticket.ticket_number = 1
    end
    @products = Product.products_all
    @order_ticket_items = @order_ticket.order_ticket_items.build
  end

  # GET /order_tickets/1/edit
  def edit
    @products = Product.all
  end

  # POST /order_tickets
  # POST /order_tickets.json
  def create
    @order_ticket = OrderTicket.new(order_ticket_params)

    respond_to do |format|
      if @order_ticket.save
        format.html { redirect_to @order_ticket, notice: 'Nota de pedido creado.' }
        format.json { render :show, status: :created, location: @order_ticket }
      else
        format.html { render :new }
        format.json { render json: @order_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_tickets/1
  # PATCH/PUT /order_tickets/1.json
  def update
    respond_to do |format|
      if @order_ticket.update(order_ticket_params)
        format.html { redirect_to @order_ticket, notice: 'Nota de pedido actualizado.' }
        format.json { render :show, status: :ok, location: @order_ticket }
      else
        format.html { render :edit }
        format.json { render json: @order_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_tickets/1
  # DELETE /order_tickets/1.json
  def destroy
    @order_ticket.destroy
    respond_to do |format|
      format.html { redirect_to order_tickets_url, notice: 'Nota de pedido eliminado.' }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_ticket
      @order_ticket = OrderTicket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_ticket_params
      params.require(:order_ticket).permit(:client_id, :ticket_number, :employee_id, :date, :observation, :state, order_ticket_items_attributes: [:id, :request_quantity, :pending_quantity, :order_ticket_id, :product_id])
    end
end
