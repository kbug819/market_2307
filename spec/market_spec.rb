require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  before(:each) do
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)

    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @vendor2.stock(@item3, 25)
    @vendor2.stock(@item4, 50)

    @vendor3 = Vendor.new("Palisade Peach Shack")
    @vendor3.stock(@item1, 65)

    @market = Market.new("South Pearl Street Farmers Market")
  end

  describe "#initialize" do
    it "instantiates a new object" do
      expect(@market).to be_an_instance_of(Market)
    end

    it "has attributes" do
      expect(@market.name).to eq("South Pearl Street Farmers Market")
      expect(@market.vendors).to eq([])
    end
  end

  describe "#add vendor" do 
    it "adds a vendor to the array of vendors" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end
  end

  describe "#vendor names" do
    it "returns a list of market's vendor names" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe "#vendors that sell" do
    it "returns a list of vendors that sell an item" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end
  end

  describe "potential revenue" do
    it "returns potential revenue if everything is sold" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@vendor1.potential_revenue).to eq(29.75)
      expect(@vendor2.potential_revenue).to eq(345.00)
      expect(@vendor3.potential_revenue).to eq(48.75)
    end
  end 

  describe "sorted item list" do
    it "returns an array of names of ittems vendors have in stock sorted alphabetically" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.sorted_item_list).to eq(["Banana Nice Cream",'Peach', "Peach-Raspberry Nice Cream",'Tomato'])
    end
  end

  # describe "list_of_items" do
  #   it "returns a list of items" do
  #     @market.add_vendor(@vendor1)
  #     @market.add_vendor(@vendor2)
  #     @market.add_vendor(@vendor3)
  #     expect(@market.list_of_items).to eq([@item1, @item2, @item3, @item4])
  #   end
  # end

  describe "#quantity" do
    it "returns total quantity of an item" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.quantity(@item1)).to eq(100)
    end
  end

  describe "total inventory" do
    it "returns a total inventory hash" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.total_inventory).to eq({
                                              @item1 => {:Quantity => 100, :Vendors => [@vendor1, @vendor3]},
                                              @item2 => {:Quantity => 7, :Vendors => [@vendor1]}, 
                                              @item3 => {:Quantity => 25, :Vendors => [@vendor2]}, 
                                              @item4 => {:Quantity => 50, :Vendors => [@vendor2]}})
    end
  end

  describe "overstocked_items" do
    it "returns an array of itmes that are overstocked" do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.overstocked_items).to eq([@item1])
    end
  end
end