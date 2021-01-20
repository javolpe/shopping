require 'date'

class Market 
  attr_reader :name,
              :vendors,
              :date

  def initialize(name)
     @name = name
     @vendors = []
     @date = Time.now.strftime("%d/%m/%Y") 
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

  def overstocked_items
    items = []
    total_inventory.select do |item, hash|
      if hash[:quantity] > 50
        items << item
      end
      #better enum here? couldn't isolate item with find_all/select 
    end
    items
  end

  def sorted_item_list
    items = total_inventory.keys.map {|item| item.name}
    items = items.sort
  end

  def sell(item, quantity)
    if total_inventory[item].nil? || total_inventory[item][:quantity] < quantity
      false
    else
      total_inventory[item][:vendors][0].inventory[item] - quantity
      true
    end 
  end
end