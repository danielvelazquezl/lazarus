class AddDeletedAtToMovementTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :movement_types, :deleted_at, :datetime
    add_index :movement_types, :deleted_at
  end
end
