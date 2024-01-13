class AddBrokerStatusToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :broker_status, :integer, default: 0
  end
end
