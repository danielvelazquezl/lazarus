class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  def index
    @client = Client.all
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      @client = Client.new(client_params)
      @client.person_id = @person.id

      respond_to do |format|
        if @client.save
          format.html { redirect_to @client, notice: 'Cliente guardado' }
        else
          @person.destroy
          format.html { render :new, notice: 'No se pudo guardar el nuevo cliente' }
        end
      end

    else
      respond do |format|
        format.html { render :new, notice: 'No se pudo guardar el nuevo cliente' }
      end
    end
  end

  def edit
    @person = Person.find_by(id: set_client.person_id)
  end

  def update
    respond_to do |format|
      if @client.update(client_params) and @person.update(person_params)
        format.html { redirect_to @client, notice: 'Datos del cliente actualizados'}
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_path }
      format.js { render :layout => false }
    end
  end


  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:ruc, :person_id)
    end

    def person_params
      params.require(:person).permit(:name, :address, :phone, :email)
    end
end
