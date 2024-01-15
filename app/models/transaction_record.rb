class TransactionRecord < ApplicationRecord
    belongs_to :stock
    belongs_to :buyer, class_name: 'User', dependent: :destroy
    belongs_to :seller, class_name: 'User', dependent: :destroy
    inverse_of: :transaction_records
  
    validates :price, numericality: { greater_than: 0 }
    validates :quantity, numericality: { greater_than: 0 }
  end
  