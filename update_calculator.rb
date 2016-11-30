class UpdateCalculator

  def decrease(item, is_conjured)
    return 2 if is_conjured
    item.sell_in == 0 ? 2 : 1
  end

  def increase(item)
    item.quality >= 50 ? 0 : 1
  end

  def backstage_increase(sell_in)
    return 3 if sell_in <= 5
    sell_in <= 10 ? 2 :1
  end

end
