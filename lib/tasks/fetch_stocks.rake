# lib/tasks/fetch_stocks.rake
namespace :stocks do
    desc 'Fetch and save tech stocks'
    task fetch_tech_stocks: :environment do
      client = IEX::Api::Client.new(
        publishable_token: 'pk_953a166c4fba4c748c12a0becf93aebd',
        endpoint: 'https://cloud.iexapis.com/v1'
      )
  
      tech_stocks = ['AAPL', 'MSFT', 'GOOGL', 'AMZN', 'FB']
  
      tech_stocks.each do |symbol|
        company = client.company(symbol)
        price = client.price(symbol)
        Stock.create(symbol: symbol, name: company.company_name, current_price: price)
      end
    end
  end