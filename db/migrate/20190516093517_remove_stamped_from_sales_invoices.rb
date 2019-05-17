class RemoveStampedFromSalesInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_column :sales_invoices, :stamped, :string
  end
end
