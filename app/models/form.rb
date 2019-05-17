class Form < ApplicationRecord

  after_save :update_stock

  belongs_to :person
  belongs_to :origin, :class_name => 'Deposit'
  belongs_to :destination, :class_name => 'Deposit'
  has_many :form_items, dependent: :delete_all
  accepts_nested_attributes_for :form_items, :allow_destroy => true

  extend Enumerize

  enumerize :form_type, in: [:cpuproduced , :keyboardmonitorrequest]

  scope :cpuproduced_form, ->{where(form_type: :cpuproduced)}
  scope :keyboardmonitorrequest_form, ->{where(form_type: :keyboardmonitorrequest)}


  private
  def update_stock

    form_items.each do |ft|
      quantity = ft.quantity
      product_id = ft.product_id

      Stock.reduce_stock(product_id, self.origin, quantity)

      Stock.increase_stock(product_id, self.destination, quantity)

      end
  end
end
