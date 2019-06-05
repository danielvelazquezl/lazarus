class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :edit, :update ,:destroy]
  def index
    (@filterrific = initialize_filterrific(
        Provider,
        params[:filterrific],
        select_options: {
            sorted_by: Provider.options_for_sorted_by
        },
        )) || return
    @provider = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @provider = Provider.new
    @provider_categories = @provider.provider_categories.build
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      @provider = Provider.new(provider_params)
      @provider.person_id = @person.id

      respond_to do |format|
        if @provider.save
          format.html { redirect_to @provider, notice: 'Providere guardado' }
        else
          @person.destroy
          format.html { render :new, notice: 'No se pudo guardar el nuevo Providere' }
        end
      end

    else
      respond do |format|
        format.html { render :new, notice: 'No se pudo guardar el nuevo Providere' }
      end
    end
  end

  def edit
    @person = Person.find_by(id: set_provider.person_id)
  end

  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to @provider, notice: 'Datos del Providere actualizados'}
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to providers_path }
      format.js { render :layout => false }
    end
  end


  private
  def set_provider
    @provider = Provider.find(params[:id])
  end

  def provider_params
    params.require(:provider).permit(:ruc, :person_id, provider_categories_attributes: [:id, :provider_id, :product_category_id])
  end

  def person_params
    params.require(:person).permit(:name, :address, :phone, :email)
  end
end