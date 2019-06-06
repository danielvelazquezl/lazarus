class CashMovement < ApplicationRecord
  has_many :cash_movement_invoices
  has_many :cash_movement_values
  belongs_to :client
  belongs_to :cash
  accepts_nested_attributes_for :cash_movement_values, :allow_destroy => true
  accepts_nested_attributes_for :cash_movement_invoices, :allow_destroy => true


end
