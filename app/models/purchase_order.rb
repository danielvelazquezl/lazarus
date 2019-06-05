class PurchaseOrder < ApplicationRecord
  belongs_to :provider
  belongs_to :employee
  has_many :purchase_order_items, dependent: :delete_all
  accepts_nested_attributes_for :purchase_order_items, :allow_destroy => true
  extend Enumerize
  enumerize :state, in: [:created, :received, :invoiced]

  def self.create_purchase_order(budget_items)
    budget_items.each do |item|
      request_id = item.budget_request.purchase_request_id
      @purchase_order = PurchaseOrder.find_or_create_by(provider_id: item.budget_request.provider_id, purchase_request_id: request_id ) do |order|
        order.provider_id = item.budget_request.provider_id
        order.employee_id = 1
        order.date = Time.now
        order.state = :created
        order.purchase_request_id = request_id
        if PurchaseOrder.any?
          order.number = PurchaseOrder.last.number + 1
        else
          order.number = 1
        end
      end
      if @purchase_order
        #@purchase_request_items = @purchase_order.purchase_order_items.create(product_id: 1, price: 10000, requested_quantity: 5, received_quantity: 0)
        @purchase_request_items = @purchase_order.purchase_order_items.create(product_id: item.product_id, price: item.price, requested_quantity: item.requested_quantity, received_quantity: 0)
      end
    end
  end

end
