class CashMovementInvoice < ApplicationRecord
  belongs_to :cash, :class_name => 'CashMovement'
end
