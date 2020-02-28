class CreatePurchaseRequestItems < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_request_items do |t|
      t.references :purchase_request, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
