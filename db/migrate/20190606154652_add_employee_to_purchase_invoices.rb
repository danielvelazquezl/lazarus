class AddEmployeeToPurchaseInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :purchase_invoices, :employee_id, references: :employee
  end
end
