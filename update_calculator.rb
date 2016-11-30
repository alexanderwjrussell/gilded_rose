class UpdateCalculator

  def decrease(item, is_conjured)
    if is_conjured
      return 2
    end

    if item.sell_in == 0
      return 2
    end
    1
  end

  def increase(item)
    if item.quality >= 50
      return 0
    end
    1
  end

  def backstage_increase(sell_in)
    if sell_in <= 5
      return 3
    end

    if sell_in <= 10
      return 2
    end
    1
  end

end
