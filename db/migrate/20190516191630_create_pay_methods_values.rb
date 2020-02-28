class CreatePayMethodsValues < ActiveRecord::Migration[5.2]
  def change
    create_table :pay_methods_values do |t|
      t.string :description
      t.references :pay_method, foreign_key: true

      t.timestamps
    end
  end
end
