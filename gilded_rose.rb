require_relative 'item'
require_relative 'item_checker'
require_relative 'update_calculator'

class GildedRose

  attr_reader :items

  def initialize(items)
    @items = items
    @item_checker = ItemChecker.new
    @update_calculator = UpdateCalculator.new
  end

  def update_stock
    @items.each do |item|
      if item.name != "Sulfuras, Hand of Ragnaros"
        update_quality(item)
        update_sell_in(item)
      end
    end
  end

  def update_quality(item)
    if (@item_checker.increases_over_time?(item.name))
      increase_quality(item)
    else
      decrease_quality(item)
    end
  end

  def update_sell_in(item)
    if item.sell_in > 0
      item.sell_in -= 1
    end
  end

  def increase_quality(item)
    item.quality += calculate_increase(item)

    if @item_checker.expired?(item.sell_in)
      item.quality = 0
    end
  end

  def calculate_increase(item)
    if @item_checker.is_backstage_pass?(item.name)
      @update_calculator.backstage_increase(item.sell_in)
    else
      @update_calculator.increase(item)
    end

  end

  def decrease_quality(item)
    if item.quality - @update_calculator.decrease(item, @item_checker.is_conjured?(item.name)) >= 0
      item.quality -= @update_calculator.decrease(item, @item_checker.is_conjured?(item.name))
    end
  end
end
