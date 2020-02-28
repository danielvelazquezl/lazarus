class AddPayMethodToSalesInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_invoices, :pay_method_id, :integer

  end
end
