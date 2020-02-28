class AddAbleToPermissions < ActiveRecord::Migration[5.2]
  def change
    add_column :permissions, :able, :boolean
  end
end
