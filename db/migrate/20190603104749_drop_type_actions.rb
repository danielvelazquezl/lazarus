class DropTypeActions < ActiveRecord::Migration[5.2]
  def change
    drop_table :permissions
    drop_table :type_actions
  end
end
