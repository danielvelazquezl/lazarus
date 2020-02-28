class CreateFormItems < ActiveRecord::Migration[5.2]
  def change
    create_table :form_items do |t|
      t.references :form, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
