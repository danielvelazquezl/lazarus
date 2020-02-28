class CreateStampeds < ActiveRecord::Migration[5.2]
  def change
    create_table :stampeds do |t|
      t.integer :number
      t.integer :first_number
      t.string :last_number
      t.date :start_date
      t.date :finish_date
      t.string :name
      t.string :expedition
      t.string :branch_office

      t.timestamps
    end
  end
end
