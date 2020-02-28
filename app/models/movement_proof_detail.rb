class MovementProofDetail < ApplicationRecord

  belongs_to :movement_proof
  belongs_to :product

  def product
    Product.unscoped { super }
  end

end
