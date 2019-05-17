class AddNewValuesToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :brand, foreign_key: true
    add_reference :products, :product_category, foreign_key: true
  end
end
