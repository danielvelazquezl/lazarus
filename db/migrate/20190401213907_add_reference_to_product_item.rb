class AddReferenceToProductItem < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :product_items, :products, column: :component_id
  end
end
