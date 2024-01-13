class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.belongs_to :stock
      t.integer :transaction_type
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity
      t.timestamps
    end
  end
end
