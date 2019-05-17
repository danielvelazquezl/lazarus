class RemoveOrderTicketFromSalesInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_column :sales_invoices, :order_ticket_id, :integer
    remove_column :sales_invoices, :pay_method_id, :integer
  end
end
