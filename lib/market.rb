class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    list = []
    @vendors.each do |vendor|
      if vendor.inventory.include?(item)
        list << vendor
      end
    end
    list
  end

  def sorted_item_list
    list_item_names = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item|
        list_item_names << item[0].name
      end
    end
    list_item_names.uniq.sort
  end
end