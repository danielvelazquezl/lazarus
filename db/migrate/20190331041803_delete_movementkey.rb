class DeleteMovementkey < ActiveRecord::Migration[5.2]
  def change
      remove_foreign_key "movement_proofs", "people"
  end
end
