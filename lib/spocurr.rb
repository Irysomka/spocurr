class Money
  attr_accessor :amount, :currency
  
  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def inspect
    "#{@amount} #{@currency}"     
  end

  def self.conversion_rates(base_currency=nil, rates_hash=nil)
    @base_currency = base_currency || "EUR"
    @rates_hash = rates_hash || { 'USD'=> 1.11, 'Bitcoin' => 0.0047 }
  end

  def self.base_currency
    @base_currency
  end

  def self.rates_hash
    @rates_hash
  end

  def convert_to(currency)
  end
end
