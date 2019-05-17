class AddColumnToSettings < ActiveRecord::Migration[5.2]
  def up
    Setting.create( :key => "nextInvoices",
                    :value => "1")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
