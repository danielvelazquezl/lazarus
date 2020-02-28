class OpenCloseCashesController < ApplicationController
  before_action :set_open_close_cash, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /open_close_cashes
  # GET /open_close_cashes.json
  def index
    (@filterrific = initialize_filterrific(
        OpenCloseCash,
        params[:filterrific],
        select_options: {
            sorted_by: OpenCloseCash.options_for_sorted_by
        },
        )) || return
    @open_close_cashes = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /open_close_cashes/1
  # GET /open_close_cashes/1.json
  def show
  end

  # GET /open_close_cashes/new
  def new
    @open_close_cash = OpenCloseCash.new
    @open_cashes = Cash.all_open
    @closed_cashes = Cash.all_close
  end

  # GET /open_close_cashes/1/edit
  def edit
    @open_cashes = Cash.all_open
    @closed_cashes = Cash.all_close
  end

  # POST /open_close_cashes
  # POST /open_close_cashes.json
  def create

    @open_close_cash = OpenCloseCash.new(open_close_cash_params)

    respond_to do |format|
      @open_close_cash.cash.state = true
      @open_close_cash.final_ammount = @open_close_cash.start_ammount
      @open_close_cash.cash.save
      if @open_close_cash.save
        format.html { redirect_to open_close_cashes_path, notice: 'Apertura de caja concretada' }
        format.json { render :show, status: :created, location: @open_close_cash }
      else
        format.html { render :new }
        format.json { render json: @open_close_cash.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /open_close_cashes/1
  # PATCH/PUT /open_close_cashes/1.json
  def update
    respond_to do |format|
      if @open_close_cash.update(open_close_cash_params)
        #se cierra caja
        @open_close_cash.cash.state = false
        #cierre de caja
        @open_close_cash.state = false
        @open_close_cash.cash.save
        @open_close_cash.save
        format.html { redirect_to open_close_cashes_path, notice: 'Cierre de caja concretada' }
        format.json { render :show, status: :ok, location: @open_close_cash }
      else
        format.html { render :edit }
        format.json { render json: @open_close_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /open_close_cashes/1
  # DELETE /open_close_cashes/1.json
  def destroy
    @open_close_cash.destroy
    respond_to do |format|
      format.html { redirect_to open_close_cashes_url, notice: 'Open close cash was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_open_close_cash
      @open_close_cash = OpenCloseCash.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def open_close_cash_params
      params.require(:open_close_cash).permit(:employee_id, :start_ammount, :date_start, :final_ammount, :final_date,:cash_id, :state, :balance)
    end
end
