class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.references :person, foreign_key: true
      t.string :ruc
      t.integer :credit_limit

      t.timestamps
    end
  end
end
