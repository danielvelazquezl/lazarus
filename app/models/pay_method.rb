class PayMethod < ApplicationRecord
  has_many :payment_cash_movement_value, :class_name => 'CashMovementValue', :foreign_key => 'payment_id'

end
