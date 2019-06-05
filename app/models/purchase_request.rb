class PurchaseRequest < ApplicationRecord
  after_update :generate_budget_request

  belongs_to :employee
  has_many :budget_requests
  has_many :purchase_request_items, dependent: :delete_all
  accepts_nested_attributes_for :purchase_request_items, :allow_destroy => true

  extend Enumerize

  enumerize :state, in: [:generated, :pending]

  private

  def generate_budget_request
    employee_id = self.employee_id
    purchase_request_id = self.id

    purchase_request_items.each do |pr|
      product_id = pr.product_id
      @product = Product.where(id: product_id).first
      category_id = @product.product_category_id
      requested_quantity = pr.quantity

      @provider_category_list = ProviderCategory.where(product_category_id: category_id)

      @provider_category_list.each do |pc|
        provider_category_id = pc.product_category_id
        provider_id = pc.provider_id

        if provider_category_id == category_id
          @budget_request = BudgetRequest.find_or_create_by(provider_id: provider_id) do |budget_request|
            budget_request.employee_id = employee_id
            budget_request.date = Time.now
            budget_request.state = :created
            budget_request.purchase_request_id = purchase_request_id
          end

          if @budget_request
            @budget_request_items = @budget_request.budget_request_items.find_or_create_by(product_id: product_id) do |bri|
              bri.requested_quantity = requested_quantity
            end
          end
        end

      end
    end
  end

  def self.modify_purchase_request(product_id, stock_quantity, min_stock_quantity, quantity)
    new_quantity = stock_quantity - quantity

    if new_quantity <= min_stock_quantity
      @purchase_request = PurchaseRequest.find_or_create_by(date: Time.now.midnight.to_formatted_s(:db)) do |purchase_request|
        purchase_request.employee_id = 1
        purchase_request.state = :pending
        purchase_request.comment = "Test"
        purchase_request.number = 123
      end

      if @purchase_request
        @purchase_request_items = @purchase_request.purchase_request_items.find_or_create_by(product_id: product_id, quantity: min_stock_quantity)
      end

    end
  end
end


