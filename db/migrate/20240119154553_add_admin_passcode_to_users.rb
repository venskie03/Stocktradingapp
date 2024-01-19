class AddAdminPasscodeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin_passcode, :string
  end
end
