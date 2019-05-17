class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  def index
  end

  def show
  end

  def new
    @person = Person.new
    @person.build_client
  end

  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Cliente guardado.' }
        #format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, notice: 'cliente no guardado' }
        #format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    #missing
  end

  def update
    #missing
  end

  def destroy
    #missing
  end


  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:person_id, :ruc)
    end

    def person_params
      params.require(:person).permit(:id, :name, :address, :phone, :email)
    end
end
