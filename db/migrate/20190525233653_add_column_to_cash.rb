class AddColumnToCash < ActiveRecord::Migration[5.2]
  def change
    add_column :cashes, :state, :boolean
  end
end
