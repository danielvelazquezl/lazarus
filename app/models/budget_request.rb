class BudgetRequest < ApplicationRecord
  belongs_to :provider
  belongs_to :employee
  belongs_to :purchase_request
  has_many :budget_request_items, dependent: :delete_all
  accepts_nested_attributes_for :budget_request_items, :allow_destroy => true

  extend Enumerize

  enumerize :state, in: [:created, :finished]
end