class FormItem < ApplicationRecord
  belongs_to :form
  belongs_to :product
  validates :quantity, numericality: true, :presence => { message: "Solo numeros positivos"}

end
