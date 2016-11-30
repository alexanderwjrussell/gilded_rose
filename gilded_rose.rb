require_relative 'item'
require_relative 'item_checker'

class GildedRose

  attr_reader :items

  def initialize(items)
    @items = items
    @item_checker = ItemChecker.new
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
    if @item_checker.expired?(item.sell_in)
      return item.quality = 0
    end

    if @item_checker.is_backstage_pass?(item.name)
      if item.sell_in <= 5
        return item.quality += 3
      end
      if item.sell_in <= 10
        return item.quality += 2
      end
      return item.quality += 1
    end

    if item.quality >= 50
      return item.quality += 0
    end
    return item.quality += 1
  end

  def decrease_quality(item)
    if item.quality > 0
      if @item_checker.is_conjured?(item.name)
        return item.quality -= 2
      end

      if item.sell_in == 0
        return item.quality -= 2
      end
      item.quality -= 1
    end
  end
end
