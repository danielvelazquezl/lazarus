class CreatePurchaseInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_invoice_items do |t|
      t.references :purchase_invoice, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.integer :price
      t.integer :iva
      t.integer :sub_total

      t.timestamps
    end
  end
end
