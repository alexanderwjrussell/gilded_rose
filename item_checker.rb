class ItemChecker

  def is_backstage_pass?(item_name)
    item_name.include? "Backstage passes"
  end

  def is_aged_brie?(item_name)
    item_name.include? "Aged Brie"
  end

  def is_conjured?(item_name)
    item_name.include? "Conjured"
  end

  def increases_over_time?(item_name)
    is_backstage_pass?(item_name) || is_aged_brie?(item_name)
  end

  def expired?(sell_in)
    sell_in == 0
  end
end
