class ChangeColumnNamePurchaseInvoice < ActiveRecord::Migration[5.2]
  def change
    rename_column :purchase_invoices, :employee_id_id, :employee_id
  end
end
