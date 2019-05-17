class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :product_type
      t.string :bar_code
      t.string :description
      t.integer :unit_cost
      t.string :location

      t.timestamps
    end
  end
end
