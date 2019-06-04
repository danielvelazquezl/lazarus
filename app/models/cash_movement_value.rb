class CashMovementValue < ApplicationRecord
  belongs_to :cash_movement
  belongs_to :pay_method


  scope :find_by_cash_mov, ->(id) {where(cash_movement_id: id)}
end
