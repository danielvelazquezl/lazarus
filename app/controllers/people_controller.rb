class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def clients
    #traer de clients
    @clients = Person.all
  end

  def show
  end

  def new_client
    @person = Person.new
    @client = Client.new
    @person.client = @client
  end

  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'guardado.' }

      else
        format.html { redirect_to clients_people_path }
        #format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :address, :phone, :email)
  end

  def client_params
    params.require(:client).permit(:person_id, :ruc, :credit_limit)
  end

end
