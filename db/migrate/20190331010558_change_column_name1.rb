class ChangeColumnName1 < ActiveRecord::Migration[5.2]
  def change
    rename_column :forms, :orig_deposit, :origin_id
    rename_column :forms, :dest_deposit, :destination_id
  end
end
