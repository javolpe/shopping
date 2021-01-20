class Market 
  attr_reader :name,
              :vendors 

  def initialize(name)
     @name = name
     @vendors = []
  end

  def add_vendor(vendor)
    vendors << vendor
  end

  def vendor_names
    vendors.map{|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def total_inventory
    inventory = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, item_qty|
        inventory[item] ||= {quantity: 0, vendors: []}
        inventory[item][:quantity] += item_qty
        inventory[item][:vendors] << vendor
      end
    end
    inventory
  end


end