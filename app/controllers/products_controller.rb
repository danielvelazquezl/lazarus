class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
 load_and_authorize_resource

  # GET /products
  # GET /products.json
  #lists all products from deposit 1
  def index
    @products = Product.products_from_d1
    if params[:filter].present? then

      if params[:product_type].present?
        @products = @products.where(product_type: params[:product_type])
      end
      if params[:product_category_id].present?
        @products = @products.where(product_category_id: params[:product_category_id])
      end
      if params[:brand_id].present?
        @products = @products.where(brand_id: params[:brand_id])
      end
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.product_type= :product
    @product_items = @product.product_items.build
    @components = Product.where(product_type: :component).map {|product| [product.description, product.id]}

  end

  # GET /products/1/edit
  def edit

  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Producto creado.' }
        format.json { render :show, status: :created, location: @product }

      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Producto actualizado.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Producto eliminado.' }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  def new_component
    @product = Product.new
    @product.product_type = :component
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
        params.require(:product).permit(:product_type, :bar_code, :description, :unit_cost, :location, :brand_id, :product_category_id, :image, product_items_attributes: [:id, :quantity, :component_id])
    end
end
