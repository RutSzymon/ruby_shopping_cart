# frozen_string_literal: true

require 'bigdecimal'
require 'pry'
Dir['./item_value_logic/*.rb'].sort.each { |file| require file }
Dir['./total_value_logic/*.rb'].sort.each { |file| require file }

class Checkout
  PRODUCTS = {
    '001' => { name: 'Red Scarf', price: BigDecimal('9.25') },
    '002' => { name: 'Silver cufflinks', price: BigDecimal('45.00') },
    '003' => { name: 'Silk Dress', price: BigDecimal('19.95') }
  }.freeze

  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @promotional_prices = {}
    @items = []
    @sum = 0
  end

  def scan(item)
    @items << item
  end

  def total
    item_value_logic
    sum_items
    total_value_logic
    "£#{@total.to_f.round(2)}"
  end

  private

  def item_value_logic
    @promotional_rules[:item_rules].each do |rule|
      @promotional_prices.merge!(Object.const_get("ItemValueLogic::#{classify(rule)}").new(@items).execute)
    end
  end

  def sum_items
    @sum = @items.sum { |item| @promotional_prices[item] || PRODUCTS.dig(item, :price) }
  end

  def total_value_logic
    @total = @sum.dup
    @promotional_rules[:total_rules].each do |rule|
      operation, value = Object.const_get("TotalValueLogic::#{classify(rule)}").new(@items, @sum).execute
      @total = @total.public_send(operation, value)
    end
  end

  def classify(rule)
    rule.to_s.split('_').collect!(&:capitalize).join
  end
end
