class MovementProofsController < ApplicationController
  before_action :set_movement_proof, only: [:show, :edit, :update, :destroy]

  # GET /movement_proofs
  # GET /movement_proofs.json
  def index
    @movement_proofs = MovementProof.all
    if params[:filter].present? then

      if params[:person_id].present?
        @movement_proof= @movement_proofs.where(person_id: params[:person_id])
      end
    end
  end

  # GET /movement_proofs/1
  # GET /movement_proofs/1.json
  def show
  end

  # GET /movement_proofs/new
  def new
    @movement_proof = MovementProof.new
    @movement_proof_details = @movement_proof.movement_proof_details.build
  end

  # GET /movement_proofs/1/edit
  def edit
    @deposit = Deposit.all.map {|deposit| [deposit.description, deposit.id]}
    @product = Product.all.map {|product| [product.description, product.id]}
    @movement_type = MovementType.all.map {|movement_type| [movement_type.description, movement_type.id]}
  end

  # POST /movement_proofs
  # POST /movement_proofs.json
  def create
    @movement_proof = MovementProof.new(movement_proof_params)

    respond_to do |format|
      if @movement_proof.save
        format.html {redirect_to @movement_proof, notice: 'Movement proof was successfully created.'}
        format.json {render :show, status: :created, location: @movement_proof}
      else
        format.html {render :new}
        format.json {render json: @movement_proof.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /movement_proofs/1
  # PATCH/PUT /movement_proofs/1.json
  def update
    respond_to do |format|
      if @movement_proof.update(movement_proof_params)
        format.html {redirect_to @movement_proof, notice: 'Movement proof was successfully updated.'}
        format.json {render :show, status: :ok, location: @movement_proof}
      else
        format.html {render :edit}
        format.json {render json: @movement_proof.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /movement_proofs/1
  # DELETE /movement_proofs/1.json
  def destroy
    @movement_proof.destroy
    respond_to do |format|
      format.html {redirect_to movement_proofs_url, notice: 'Movement proof was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_movement_proof
    @movement_proof = MovementProof.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def movement_proof_params
     params.require(:movement_proof).permit(:person_id, :deposit_id, :movement_type_id, :date, :comment ,movement_proof_details_attributes: [:id, :movement_proof_id, :product_id, :quantity]
    )
  end
end
