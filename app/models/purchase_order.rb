class PurchaseOrder < ApplicationRecord
  belongs_to :provider
  belongs_to :employee
  has_many :purchase_order_items, dependent: :delete_all
  accepts_nested_attributes_for :purchase_order_items, :allow_destroy => true
end
