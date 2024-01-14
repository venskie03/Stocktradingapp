class CreateTransactionRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :transaction_records do |t|
      t.belongs_to :stock, null: false, foreign_key: true
      t.references :buyer, null: false, foreign_key: { to_table: :users }, index: true
      t.references :seller, null: false, foreign_key: { to_table: :users }, index: true
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity
      t.timestamps
    end
  end
end