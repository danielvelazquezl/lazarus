class CreateMovementProofDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :movement_proof_details do |t|
      t.references :movement_proof, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
