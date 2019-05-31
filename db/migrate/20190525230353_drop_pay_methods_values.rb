class DropPayMethodsValues < ActiveRecord::Migration[5.2]
  def change
    drop_table :pay_methods_values
  end
end
