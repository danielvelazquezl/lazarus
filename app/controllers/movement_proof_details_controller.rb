class MovementProofDetailsController < ApplicationController
  before_action :set_movement_proof_detail, only: [:show, :edit, :update, :destroy]

  # GET /movement_proof_details
  # GET /movement_proof_details.json
  def index
    @movement_proof_details = MovementProofDetail.all
  end

  # GET /movement_proof_details/1
  # GET /movement_proof_details/1.json
  def show
  end

  # GET /movement_proof_details/new
  def new
    @movement_proof_detail = MovementProofDetail.new(:product_id  => 1, :quantity => 1)
    @product = Product.all.map {|product| [product.name, product.id]}
  end

  # GET /movement_proof_details/1/edit
  def edit
    @product = Product.all.map {|product| [product.name, product.id]}
  end

  # POST /movement_proof_details
  # POST /movement_proof_details.json
  def create
    @movement_proof_detail = MovementProofDetail.new(movement_proof_detail_params)

    respond_to do |format|
      if @movement_proof_detail.save
        format.html {redirect_to @movement_proof_detail, notice: 'Movement proof detail was successfully created.'}
        format.json {render :show, status: :created, location: @movement_proof_detail}
      else
        format.html {render :new}
        format.json {render json: @movement_proof_detail.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /movement_proof_details/1
  # PATCH/PUT /movement_proof_details/1.json
  def update
    respond_to do |format|
      if @movement_proof_detail.update(movement_proof_detail_params)
        format.html {redirect_to @movement_proof_detail, notice: 'Movement proof detail was successfully updated.'}
        format.json {render :show, status: :ok, location: @movement_proof_detail}
      else
        format.html {render :edit}
        format.json {render json: @movement_proof_detail.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /movement_proof_details/1
  # DELETE /movement_proof_details/1.json
  def destroy
    @movement_proof_detail.destroy
    respond_to do |format|
      format.html {redirect_to movement_proof_details_url, notice: 'Movement proof detail was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_movement_proof_detail
    @movement_proof_detail = MovementProofDetail.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def movement_proof_detail_params
    params.require(:movement_proof_detail).permit(:movement_proof_id, :product_id, :quantity)
  end
end
