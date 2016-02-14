class Money
  attr_accessor :amount, :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def inspect
    "#{@amount} #{@currency}"
  end

  def self.conversion_rates(base_currency, base_rates_hash)
    @rates_hash = {}
    currencies = base_rates_hash.keys << base_currency

    permutations = currencies.permutation(2).to_a

    base_rates_hash.each do |currency, value|
      @rates_hash[[base_currency, currency]] = value
      @rates_hash[[currency, base_currency]] = 1/value
    end

    unknown_keys = permutations - @rates_hash.keys

    unknown_keys.each do |key|
      @rates_hash[key] = @rates_hash[ [key.first, base_currency] ] * @rates_hash[[base_currency, key.last]]
    end
    @rates_hash
  end

  def self.base_currency
    @base_currency
  end

  def self.rates_hash
    @rates_hash
  end

  def convert_to(new_currency)
    return self if currency == new_currency

    self.amount = (amount.to_f * Money.rates_hash[[self.currency, new_currency]]).round(2)
    self.currency = new_currency
    self
  end

  def +(other)
    other_money = (currency == other.currency) ? other : other.convert_to(currency)
    Money.new(amount + other_money.amount, currency)
  end

  def -(other)
    other_money = (currency == other.currency) ? other : other.convert_to(currency)
    Money.new(amount - other_money.amount, currency)
  end

  def *(number)
    Money.new(amount*number, currency)
  end

  def /(number)
    Money.new(amount/number, currency)
  end

  def >(other)
    other_money = (currency == other.currency) ? other : other.convert_to(currency)
    amount > other_money.amount
  end

  def <(other)
    other_money = (currency == other.currency) ? other : other.convert_to(currency)
    amount < other_money.amount
  end
end
