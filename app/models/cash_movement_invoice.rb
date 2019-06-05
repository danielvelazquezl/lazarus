class CashMovementInvoice < ApplicationRecord
  belongs_to :cash_movement
  belongs_to :sales_invoice
  scope :find_by_cash_mov, ->(id) {where(cash_movement_id: id)}

end
