class AddOrderNumberToSetting < ActiveRecord::Migration[5.2]
  def up
    Setting.create( :key => "next_order_number",
                    :value => "1")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
