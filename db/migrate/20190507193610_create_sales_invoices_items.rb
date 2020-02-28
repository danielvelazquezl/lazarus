class CreateSalesInvoicesItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_invoices_items do |t|
      t.references :sales_invoice, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.integer :price
      t.integer :iva
      t.integer :sub_total

      t.timestamps
    end
  end
end
