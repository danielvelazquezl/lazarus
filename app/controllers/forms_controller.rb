class FormsController < ApplicationController
  before_action :set_form, only: [:show, :edit, :update, :destroy]

  # GET /forms
  # GET /forms.json
  def index
    (@filterrific = initialize_filterrific(
        Form.cpuproduced_form,
        params[:filterrific],
        select_options: {
            sorted_by: Form.options_for_sorted_by,
            with_person_id: Person.options_for_select,
        },
        )) || return
    @forms = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def request_forms_index
    (@filterrific = initialize_filterrific(
        Form.keyboardmonitorrequest_form,
        params[:filterrific],
        select_options: {
            sorted_by: Form.options_for_sorted_by,
            with_person_id: Person.options_for_select,
        },
        )) || return
    @forms = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
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
    #lastAdd = @form.number = Form.find_by(form_type: :cpuproduced)
    if Form.any?
      @form.number = Form.where(form_type: :cpuproduced).last.number + 1
    else
      @form.number = 1
    end
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
    lastAdd = @form.number = Form.find_by(form_type: :keyboardmonitorrequest)
    if lastAdd != nil
      @form.number = Form.where(form_type: :keyboardmonitorrequest).last.number + 1
    else
      @form.number = 1
    end
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
        @form_items = @form.form_items
        @form_items.each do |item|
          product = Product.find_by(id: item.product_id)
          if product.product_type == :component
            product.update_attribute(:product_type, Product.product_type.both)
          end
        end

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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_form
    @form = Form.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def form_params
    params.require(:form).permit(:person_id, :origin_id, :form_type, :destination_id, :date, :number, :comments, form_items_attributes: [:id, :quantity, :form_id, :product_id])
  end
end