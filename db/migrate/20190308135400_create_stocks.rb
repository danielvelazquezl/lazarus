class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.references :product, foreign_key: true
      t.references :deposit, foreign_key: true
      t.string :internal_code
      t.integer :quantity
      t.integer :min_stock
      t.string :stock_type

      t.timestamps
    end
  end
end
