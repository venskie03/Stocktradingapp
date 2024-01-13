class RemoveBrokerFromTransactionRecords < ActiveRecord::Migration[7.1]
  def change
    remove_reference :transaction_records, :broker, null: false, foreign_key: { to_table: :users }, index: true
    
  end
end
