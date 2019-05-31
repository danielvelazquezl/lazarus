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
    begin
      Order.transaction do
        form_items.each do |ft|
          quantity = ft.quantity
          product_id = ft.product_id

          @stock_origin = Stock.where(deposit_id: self.origin, product_id: product_id).first
          @stock_origin.reduce_stock!(product_id, quantity)

          @stock_destination = Stock.where(deposit_id: self.destination, product_id: product_id).first
          @stock_destination.increase_stock!(quantity)
        end
      end

    rescue StandardError => e

      self.errors.add(:quantity, "Cantidad insuficiente para realizar esta transaccion")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end
end
