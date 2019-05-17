class ProductItem < ApplicationRecord
  belongs_to :product
  validates :quantity, numericality: true, :presence => { message: "Solo numeros positivos"}
end
