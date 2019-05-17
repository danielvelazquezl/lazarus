class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :movement_proofs, :user_id, :person_id
  end
end
