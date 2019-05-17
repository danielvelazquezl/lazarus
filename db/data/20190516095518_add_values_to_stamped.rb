class AddValuesToStamped < ActiveRecord::Migration[5.2]
  def up
    Stamped.create( :number => 1257896,
                    :first_number => 1,
                    :last_number => 1000,
                    :start_date => Date.new(2019, 5, 31),
                    :finish_date => Date.new(2020,5,31),
                    :name => "001-001",
                    :expedition => "001",
                    :branch_office => "001"
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
