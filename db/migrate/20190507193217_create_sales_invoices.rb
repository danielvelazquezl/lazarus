class CreateSalesInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_invoices do |t|
      t.references :employee, foreign_key: true
      t.datetime :date
      t.references :client, foreign_key: true
      t.integer :total
      t.integer :iva
      t.integer :balance
      t.integer :invoice_number
      t.integer :stamped
      t.references :deposit

      t.timestamps
    end
  end
end
