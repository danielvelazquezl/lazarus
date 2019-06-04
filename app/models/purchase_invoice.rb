class PurchaseInvoice < ApplicationRecord
  belongs_to :provider
  belongs_to :deposit
  belongs_to :purchase_order
  has_many :purchase_invoice_items
  accepts_nested_attributes_for :purchase_invoice_items, :allow_destroy => true

  after_save :update_stock

  private

  def update_stock
    begin
      PurchaseInvoice.transaction do
        purchase_invoice_items.each do |si|
          quantity = si.quantity
          product_id = si.product_id

          @stock_origin = Stock.where(deposit_id: self.deposit, product_id: product_id).first
          @stock_origin.increase_stock!(quantity)

        end
      end
    rescue StandardError => e
      self.errors.add(:quantity, "Cantidad insuficiente para realizar esta transaccion")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

end
