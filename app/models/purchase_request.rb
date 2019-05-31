class PurchaseRequest < ApplicationRecord
  belongs_to :employee
  has_many :budget_requests
  has_many :purchase_request_items, dependent: :delete_all
  accepts_nested_attributes_for :purchase_request_items, :allow_destroy => true

  def self.modify_purchase_request(product_id, stock_quantity, min_stock_quantity, quantity)

    new_quantity = stock_quantity - quantity

    if new_quantity <= min_stock_quantity
      @purchase_request = PurchaseRequest.find_or_create_by(date: Time.now.midnight.to_formatted_s(:db)) do |purchase_request|
        purchase_request.employee_id = 1
        purchase_request.state = "Test"
        purchase_request.comment = "Test"
        purchase_request.number = 123

      end

      if @purchase_request
        @purchase_request_items = @purchase_request.purchase_request_items.create(product_id: product_id, quantity: min_stock_quantity)
      end
    end
  end

end
