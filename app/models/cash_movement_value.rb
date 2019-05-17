class CashMovementValue < ApplicationRecord
  belongs_to :cash, :class_name => 'CashMovement'
  belongs_to :payment, :class_name => 'PayMethod'
end
