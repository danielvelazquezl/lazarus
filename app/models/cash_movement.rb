class CashMovement < ApplicationRecord
  has_many :cash_cash_movement_invoices, :class_name => 'CashMovementInvoice', :foreign_key => 'cash_id'
  has_many :cash_cash_movement_values, :class_name => 'CashMovementValue', :foreign_key => 'cash_id'
  has_many :pay_methods_values
  belongs_to :client , :class_name => 'Client'
  extend Enumerize

  accepts_nested_attributes_for :cash_cash_movement_values, :allow_destroy => true
  accepts_nested_attributes_for :pay_methods_values, :allow_destroy => true
  enumerize :cash, in: [:Caja1 , :Caja2]
end
