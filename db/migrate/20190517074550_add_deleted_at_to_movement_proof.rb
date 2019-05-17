class AddDeletedAtToMovementProof < ActiveRecord::Migration[5.2]
  def change
    add_column :movement_proofs, :deleted_at, :datetime
    add_index :movement_proofs, :deleted_at
  end
end
