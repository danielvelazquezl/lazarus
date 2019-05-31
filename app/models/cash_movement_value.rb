class CashMovementValue < ApplicationRecord
  belongs_to :cash_movement
  belongs_to :pay_method
end
