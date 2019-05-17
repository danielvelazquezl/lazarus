class FormsController < ApplicationController
  before_action :set_form, only: [:show, :edit, :update, :destroy]

  # GET /forms
  # GET /forms.json
  def index
    @forms = Form.cpuproduced_form

  end

  def request_forms_index
    @forms = Form.keyboardmonitorrequest_form
    if params[:filter].present? then

      if params[:person_id].present?
        @forms = @forms.where(person_id: params[:person_id])
      end
      if params[:date_from].present? and params[:date_until].present?
        @forms = @forms.where("DATE(date) >= (?) and DATE(date) <= (?)", params[:date_from], params[:date_until])
      end
    end
  end

  # GET /forms/1
  # GET /forms/1.json
  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf {render template: 'forms/reporte', pdf: 'Reporte', page_size: 'A4',lowquality: true,
                         zoom: 1, layout: "pdf.html",
                         dpi: 75}
    end
  end

  # GET /forms/new
  def new
    @form = Form.new
    @form.form_type = :cpuproduced
    @form.person_id = 1
    @form.origin_id = Setting.find_by!(key: 'id_production_deposit').id
    @form.destination_id = Setting.find_by!(key: 'id_products_deposit').id
    @form.date = Time.now
    @products = Product.products_all
    @form_items = @form.form_items.build
  end


  def new_request_proof
    @form = Form.new
    @form.form_type = :keyboardmonitorrequest
    @form.person_id = 1
    @form.origin_id = Setting.find_by!(key: 'id_components_deposit').value
    @form.destination_id = Setting.find_by!(key: 'id_products_deposit').value
    @form.date = Time.now
    @products = Product.components_all
    @form_items = @form.form_items.build
  end
  # GET /forms/1/edit
  def edit
    @products = Product.all
  end

  # POST /forms
  # POST /forms.json
  def create
    @form = Form.new(form_params)

    respond_to do |format|
      if @form.save
        format.html { redirect_to @form, notice: 'Formulario creado.' }
        format.json { render :show, status: :created, location: @form }
      else
        format.html { render :new }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forms/1
  # PATCH/PUT /forms/1.json
  def update
    respond_to do |format|
      if @form.update(form_params)
        format.html { redirect_to @form, notice: 'Formulario actualizado.' }
        format.json { render :show, status: :ok, location: @form }
      else
        format.html { render :edit }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forms/1
  # DELETE /forms/1.json
  def destroy
    @form.destroy
    respond_to do |format|
      format.html { redirect_to forms_url, notice: 'Formulario eliminado.' }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  def check_stock_quantity
    
    product_id = form_params[:form_items_attributes][:product_id]
    user_input_cant = form_params[:form_items_attributes][:quantity]
    stock_cant = Stock.find(product_id).quantity

    if user_input_cant > stock_cant
      render json: { valid: false }
    else
      render json: { valid: true }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_form
    @form = Form.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def form_params
    params.require(:form).permit(:person_id, :origin_id, :form_type, :destination_id, :date, :comments, form_items_attributes: [:id, :quantity, :form_id, :product_id])
  end
end