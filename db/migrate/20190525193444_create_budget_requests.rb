class CreateBudgetRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_requests do |t|
      t.references :provider, foreign_key: true
      t.references :employee, foreign_key: true
      t.datetime :date
      t.string :state
      t.string :comment

      t.timestamps
    end
  end
end
