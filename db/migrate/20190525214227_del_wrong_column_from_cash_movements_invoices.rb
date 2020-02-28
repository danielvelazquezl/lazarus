class DelWrongColumnFromCashMovementsInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_column :cash_movement_invoices, :sales_invoices_id
    remove_column :cash_movement_invoices, :cash_movements_id
    add_reference :cash_movement_invoices, :sales_invoice, foreign_key: true
    add_reference :cash_movement_invoices, :cash_movements, foreign_key: true
  end
end
