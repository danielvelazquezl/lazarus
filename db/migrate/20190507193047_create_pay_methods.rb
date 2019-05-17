class CreatePayMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :pay_methods do |t|
      t.string :description

      t.timestamps
    end
  end
end
