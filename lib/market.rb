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

  # def list_of_items 
  #   list = []
  #   @vendors.each do |vendor|
  #     vendor.inventory.each do |item|
  #       list << item[0]
  #     end
  #   end
  #   list.uniq
  # end

  def quantity(item)
    total = 0
    @vendors.each do |vendor|
      vendor.inventory.each do |value|
        if item == value[0]
          total += value[1]
        end
      end
    end
    total

  end


  def total_inventory
    inventory_1 = Hash.new(0)
      @vendors.each do |vendor|
        vendor.inventory.each do |item|
          inventory_1[item[0]] = {:Quantity => quantity(item[0]), :Vendors => vendors_that_sell(item[0])}
        end
      end
    inventory_1
  end

  def overstocked_items
    items = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item|
        if quantity(item[0]) > 50 && vendors_that_sell(item[0]).length > 1
          items << item[0]
        end
      end
    end
    items.uniq
  end
end