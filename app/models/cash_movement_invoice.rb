class CashMovementInvoice < ApplicationRecord
  belongs_to :cash_movement

  scope :find_by_cash_mov, ->(id) {where(cash_movement_id: id)}

end
