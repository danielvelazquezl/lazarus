class CreateOpenCloseCashes < ActiveRecord::Migration[5.2]
  def change
    create_table :open_close_cashes do |t|
      t.references :employee
      t.integer :start_ammount
      t.datetime :date_start
      t.integer :final_ammount
      t.datetime :fina_date

      t.timestamps
    end
  end
end
