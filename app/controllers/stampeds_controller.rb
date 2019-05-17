class StampedsController < ApplicationController
  before_action :set_stamped, only: [:show, :edit, :update, :destroy]

  # GET /stampeds
  # GET /stampeds.json
  def index
    @stampeds = Stamped.all
  end

  # GET /stampeds/1
  # GET /stampeds/1.json
  def show
  end

  # GET /stampeds/new
  def new
    @stamped = Stamped.new
  end

  # GET /stampeds/1/edit
  def edit
  end

  # POST /stampeds
  # POST /stampeds.json
  def create
    @stamped = Stamped.new(stamped_params)

    respond_to do |format|
      if @stamped.save
        format.html { redirect_to @stamped, notice: 'Stamped was successfully created.' }
        format.json { render :show, status: :created, location: @stamped }
      else
        format.html { render :new }
        format.json { render json: @stamped.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stampeds/1
  # PATCH/PUT /stampeds/1.json
  def update
    respond_to do |format|
      if @stamped.update(stamped_params)
        format.html { redirect_to @stamped, notice: 'Stamped was successfully updated.' }
        format.json { render :show, status: :ok, location: @stamped }
      else
        format.html { render :edit }
        format.json { render json: @stamped.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stampeds/1
  # DELETE /stampeds/1.json
  def destroy
    @stamped.destroy
    respond_to do |format|
      format.html { redirect_to stampeds_url, notice: 'Stamped was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def number_stamped
    @st = Stamped.find(params.require(:id))
render :json => @st

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stamped
      @stamped = Stamped.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stamped_params
      params.require(:stamped).permit(:number, :first_number, :last_number, :start_date, :finish_date, :name, :expedition, :branch_office)
    end
end
