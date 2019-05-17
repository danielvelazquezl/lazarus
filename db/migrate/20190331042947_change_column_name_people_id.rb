class ChangeColumnNamePeopleId < ActiveRecord::Migration[5.2]
  def change
    rename_column :movement_proofs, :person_id, :user_id
  end
end
