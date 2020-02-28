class AddAdminUsers < ActiveRecord::Migration[5.2]
  def up
	User.create(:user_name => 'admin', 
	:email => 'admin@fiuni.edu.py',
  	:password => 'lazarus.v2', 
  	:password_confirmation => 'lazarus.v2') 
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
