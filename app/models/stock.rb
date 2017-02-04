class Stock < ActiveRecord::Base

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def self.new_from_lookup(ticker_symbol)
    look_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless look_up_stock.name
    new_stock = new(ticker: look_up_stock.symbol, name: look_up_stock.name)
    new_stock.last_price = new_stock.price
    new_stock

  end

  def price
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price} (Closing)" if closing_price
    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price} (Opening)" if opening_price
    'Unavailable'
  end
end