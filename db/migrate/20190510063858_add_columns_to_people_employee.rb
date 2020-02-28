class AddColumnsToPeopleEmployee < ActiveRecord::Migration[5.2]
  def change
    #columns for people
    add_column :people, :address, :string
    add_column :people, :phone, :string
    add_column :people, :email, :string

    #columns for employee
    add_column :employees, :ci, :string
    add_column :employees, :sex, :string
    add_column :employees, :birth_date, :date
    add_column :employees, :charge, :string
  end
end
