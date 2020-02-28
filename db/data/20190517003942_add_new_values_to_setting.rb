class AddNewValuesToSetting < ActiveRecord::Migration[5.2]
  def up
    Setting.create( :key => "default_stamped",
                    :value => "001-001")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
