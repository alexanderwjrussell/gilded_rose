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

  end

end
