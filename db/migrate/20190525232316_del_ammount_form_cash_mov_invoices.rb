class DelAmmountFormCashMovInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_column :cash_movement_invoices, :ammount
  end
end
