class AddDeletedAtToMovementProofDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :movement_proof_details, :deleted_at, :datetime
    add_index :movement_proof_details, :deleted_at
  end
end
