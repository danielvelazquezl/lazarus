class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /orders
  # GET /orders.json
  def index
    (@filterrific = initialize_filterrific(
        Order.products_order,
        params[:filterrific],
        select_options: {
            sorted_by: Order.options_for_sorted_by,
            with_person_id: Person.options_for_select,
        },
        )) || return
    @orders = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

  end

  def component_orders_index
    (@filterrific = initialize_filterrific(
        Order.components_order,
        params[:filterrific],
        select_options: {
            sorted_by: Order.options_for_sorted_by
        },
        )) || return
    @orders = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf {render template: 'orders/reporte', pdf: 'Reporte', page_size: 'A4',lowquality: true,
                         zoom: 1, layout: "pdf.html",
                         dpi: 75}
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.order_type = :production
    @order.person_id = 1
    @order.origin_id = Setting.find_by!(key: 'id_production_deposit').value
    @order.destination_id = Setting.find_by!(key: 'id_production_deposit').value
    @order.date_request = Time.now
    #orderLast = @order.number = Order.find_by(order_type: :production)
    if Order.any?
      @order.number = Order.where(order_type: :production).last.number + 1
    else
      @order.number = 1
    end
    @products = Product.products_all
    @order_items = @order.order_items.build
    #this creates a new, empty Order instance and two empty order_items instances belonging to Orders
  end

  #para crear un nuevo comprobante componente
  def new_component_proof
    @order = Order.new
    @order.order_type = :component
    @order.person_id = 1
    @order.origin_id = Setting.find_by!(key: 'id_components_deposit').value
    @order.destination_id = Setting.find_by!(key: 'id_production_deposit').value
    @order.date_request = Time.now
    orderLast = @order.number = Order.find_by(order_type: :component)
    if orderLast != nil
      @order.number = Order.where(order_type: :component).last.number + 1
    else
      @order.number = 1
    end
    @products = Product.components_all
    @order_items = @order.order_items.build
    #this creates a new, empty Order instance and two empty order_items instances belonging to Orders
  end

  # GET /orders/1/edit
  def edit
    get_products
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
       # render 'new'
      #end

      respond_to do |format|
        if @order.save
          format.html { redirect_to @order, notice: 'Orden agregada.' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update_attributes(order_params)
        format.html {redirect_to @order, notice: 'Orden actualizada.'}
        format.json {render :show, status: :ok, location: @order}
      else
        get_products
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
      if @order.state.finished?
        @order.date_finished = Time.now
        @order.update(order_params)
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html {redirect_to orders_url, notice: 'Order eliminada.'}
      format.json {head :no_content}
      format.js {render :layout => false}
    end
  end


  private

  def get_products
    if @order.order_type.production?
      @products = Product.products_all
    else
      @products = Product.components_all
    end
  end

  # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:person_id, :origin_id, :destination_id, :order_type, :date_request, :date_finished, :state, :number, order_items_attributes: [:id, :quantity, :order_id, :product_id])
  end

end
