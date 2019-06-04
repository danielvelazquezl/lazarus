class BudgetRequest < ApplicationRecord
  belongs_to :provider
  belongs_to :employee
  belongs_to :purchase_request
  has_many :budget_request_items, dependent: :delete_all
  accepts_nested_attributes_for :budget_request_items, :allow_destroy => true

  extend Enumerize

  enumerize :state, in: [:created, :finished]


  def self.get_cheapest_items(purchase_request)
    budget_requests = BudgetRequest.where(purchase_request_id: purchase_request.id)
    budget_items = []
    budget_requests.each do |item|
      budget_items.concat( BudgetRequestItem.joins(:budget_request).where("budget_request_id = ?", item.id))
    end
    #budget_items = BudgetRequestItem.joins(:budget_request).where("budget_request_id = ?", self.id)
    sorted_items = budget_items.sort_by { |bi| bi.price }
    cheapest_products = sorted_items.uniq { |ch| ch.product_id }
    return cheapest_products
  end
end