class AddNewValuesToProductItems < ActiveRecord::Migration[5.2]
  def change
    add_column :product_items, :component_id, :integer
  end
end
