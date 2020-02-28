class CorrectCashMovementsInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_column :cash_movement_invoices, :cash_movements_id
    add_reference :cash_movement_invoices, :cash_movement, foreign_key: true
  end
end
