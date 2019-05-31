class SalesInvoice < ApplicationRecord
  belongs_to :employee
  belongs_to :client
  belongs_to :deposit
  belongs_to :pay_method
  belongs_to :order_ticket
  has_one :stamped
  has_many :sales_invoices_items
  accepts_nested_attributes_for :sales_invoices_items, :allow_destroy => true

  scope :find_by_client, ->(id) {where(client_id: id)}

  after_save :update_stock

  private

  def update_stock
    # sales_invoices_items.each do |si|
    #   quantity = si.quantity
    #   product_id = si.product_id
    #
    #   Stock.reduce_stock(product_id, self.deposit, quantity)
    #
    begin
      SalesInvoice.transaction do

        sales_invoices_items.each do |si|
          quantity = si.quantity
          product_id = si.product_id

          @stock_origin = Stock.where(deposit_id: self.deposit, product_id: product_id).first
          @stock_origin.reduce_stock!(product_id, quantity)

        end
      end
    rescue StandardError => e
      self.errors.add(:quantity, "Cantidad insuficiente para realizar esta transaccion")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

end



