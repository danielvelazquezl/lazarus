class CreatePurchaseOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_order_items do |t|
      t.references :purchase_order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :price
      t.integer :requested_quantity
      t.integer :received_quantity

      t.timestamps
    end
  end
end
