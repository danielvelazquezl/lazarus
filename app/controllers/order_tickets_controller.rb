class OrderTicketsController < ApplicationController
  before_action :set_order_ticket, only: [:show, :edit, :update, :destroy]

  # GET /order_tickets
  # GET /order_tickets.json
  def index
    @order_tickets = OrderTicket.all
  end

  # GET /order_tickets/1
  # GET /order_tickets/1.json
  def show
  end

  # GET /order_tickets/new
  def new
    @order_ticket = OrderTicket.new
  end

  # GET /order_tickets/1/edit
  def edit
  end

  # POST /order_tickets
  # POST /order_tickets.json
  def create
    @order_ticket = OrderTicket.new(order_ticket_params)

    respond_to do |format|
      if @order_ticket.save
        format.html { redirect_to @order_ticket, notice: 'Order ticket was successfully created.' }
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
        format.html { redirect_to @order_ticket, notice: 'Order ticket was successfully updated.' }
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
      format.html { redirect_to order_tickets_url, notice: 'Order ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_ticket
      @order_ticket = OrderTicket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_ticket_params
      params.require(:order_ticket).permit(:client_id, :ticket_number, :employee_id, :pay_method_id, :date, :observation, :state)
    end
end
