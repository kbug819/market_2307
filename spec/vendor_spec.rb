require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  before(:each) do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})

    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  describe "#initialize" do
    it "instantiates a new object" do
      expect(@vendor).to be_an_instance_of(Vendor)
    end

    it "has attributes" do
      expect(@vendor.name).to eq("Rocky Mountain Fresh")
      expect(@vendor.inventory).to eq({})
    end
  end

  describe "#check stock" do 
    it "returns the number of items" do
      
end