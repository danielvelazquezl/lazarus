class CreateMovementProofs < ActiveRecord::Migration[5.2]
  def change
    create_table :movement_proofs do |t|
      t.references :person, foreign_key: true
      t.references :deposit, foreign_key: true
      t.references :movement_type, foreign_key: true
      t.datetime :date
      t.string :comment

      t.timestamps
    end
  end
end
