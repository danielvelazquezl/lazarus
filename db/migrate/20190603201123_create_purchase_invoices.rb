class CreatePurchaseInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_invoices do |t|
      t.references :provider, foreign_key: true
      t.datetime :date
      t.integer :total
      t.integer :iva
      t.integer :balance
      t.string :invoice_number
      t.string :stamped
      t.references :deposit, foreign_key: true
      t.references :pay_method, foreign_key: true
      t.references :purchase_order, foreign_key: true

      t.timestamps
    end
  end
end
