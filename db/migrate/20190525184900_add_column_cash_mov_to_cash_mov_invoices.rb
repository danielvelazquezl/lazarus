class AddColumnCashMovToCashMovInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :cash_movement_invoices, :cash_movements, foreign_key: true
  end
end
