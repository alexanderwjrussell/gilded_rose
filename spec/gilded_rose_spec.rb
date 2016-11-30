require_relative '../gilded_rose'

describe GildedRose do

  before :each do
    items = []
    items << Item.new("+5 Dexterity Vest", 10, 20)
    items << Item.new("Aged Brie", 2, 0)
    items << Item.new("Elixir of the Mongoose", 5, 7)
    items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    items << Item.new("Conjured Mana Cake", 3, 6)

    @gilded_rose = GildedRose.new(items)
  end

  describe "#update_quality" do
    it "does not change the name" do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[0].name).to eq "+5 Dexterity Vest"
    end

    it "should decrease quality at the end of the day" do
      quality_before = @gilded_rose.items[0].quality
      @gilded_rose.update_quality
      quality_after = @gilded_rose.items[0].quality
      expect(quality_before > quality_after).to eq true
    end

    it "should decrease the sell_in at the end of the day" do
      sell_before = @gilded_rose.items[0].sell_in
      @gilded_rose.update_quality
      sell_after = @gilded_rose.items[0].sell_in
      expect(sell_before > sell_after).to eq true
    end

    it "should decrease quality twice as fast when out of date" do
      item = @gilded_rose.items[0]
      initial_quality = item.quality
      item.sell_in = 1
      @gilded_rose.update_quality
      middle_quality = item.quality
      @gilded_rose.update_quality
      initial_difference = initial_quality - middle_quality
      final_difference = middle_quality - item.quality
      expect(final_difference == 2*initial_difference).to eq(true)
    end

    it "should never have a quality less than zero" do
      item = @gilded_rose.items[0]
      item.quality = 0
      @gilded_rose.update_quality
      expect(item.quality == 0).to eq(true)
    end

    it "should increase aged brie in quality the older it gets" do
      item = @gilded_rose.items[1]
      initial_quality = item.quality
      @gilded_rose.update_quality
      expect(item.quality > initial_quality).to eq(true)
    end

    it "should not allow an items quality to become more than 50" do
      item = @gilded_rose.items[1]
      item.quality = 50
      @gilded_rose.update_quality
      expect(item.quality == 50).to eq(true)
    end
  end
end
