class CashMovementValue < ApplicationRecord
  belongs_to :cash_movement
  belongs_to :pay_method
  belongs_to :bank

  scope :find_by_cash_mov, ->(id) {where(cash_movement_id: id)}

  scope :find_cash_mov_total_by_pay_method, ->(id, pay_id) {where(cash_movement_id: id, pay_method_id: pay_id ).sum("ammount")}
end
