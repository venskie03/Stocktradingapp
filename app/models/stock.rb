class Stock < ApplicationRecord
    has_many :user_stocks, dependent: :destroy
    has_many :users, through: :user_stocks
    has_many :orders, dependent: :destroy
    has_many :transaction_records, dependent: :nullify
  
    validates :ticker,       presence: true,
                             uniqueness: true
    validates :company_name, presence: true
    validates :last_transaction_price, numericality: { greater_than: 0 }
    validates :quantity, numericality: { greater_than: 0 }
  
    def update_last_price(price)
      self.last_transaction_price = price
      save!
    end


    # # check the IEX api for current stock lineup and prices

    # def self.update_stocks
    #   stocks = Stock.all
    #   stocks.each do |stock|
    #     stock.update_last_price(stock.current_price)
    #   end
    # end

    # def current_price
    #   IEX::Resources::Price.get(ticker).price
    # end
  
    # def self.find_by_ticker(ticker_symbol)
    #   where(ticker: ticker_symbol).first
    # end
  
    # def self.new_from_lookup(ticker_symbol)
    #   looked_up_stock = IEX::Resources::Company.get(ticker_symbol)
    #   return nil unless looked_up_stock
    #   new_stock = new(ticker: looked_up_stock.symbol, company_name: looked_up_stock.company_name)
    #   new_stock.last_transaction_price = new_stock.current_price
    #   new_stock
    # end

    # refer to the IEX configuration in config/initializers/iex.rb and query for the current stock lineup and prices

    def self.update_stocks
      stocks = Stock.all
      stocks.each do |stock|
        stock.update_last_price(stock.current_price)
      end
    end

    def current_price
      client = IEX::Api::Client.new(
        publishable_token: 'pk_953a166c4fba4c748c12a0becf93aebd',
        endpoint: 'https://api.iex.cloud/v1/'
      )
      client.price(ticker)
    end
  
    def self.find_by_ticker(ticker_symbol)
      where(ticker: ticker_symbol).first
    end
  
    def self.new_from_lookup(ticker_symbol)
      client = IEX::Api::Client.new(
        publishable_token: 'pk_953a166c4fba4c748c12a0becf93aebd',
        endpoint: 'https://api.iex.cloud/v1/'
      )
      looked_up_stock = client.company(ticker_symbol)
      return nil unless looked_up_stock
      new_stock = new(ticker: looked_up_stock.symbol, company_name: looked_up_stock.company_name)
      new_stock.last_transaction_price = new_stock.current_price
      new_stock
    end
  end
  