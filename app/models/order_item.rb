class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, numericality: true, :presence => { message: "Solo numeros positivos"}
end
