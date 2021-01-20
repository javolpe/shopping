class Vendor 
  attr_reader :name,
              :inventory
  
  def initialize(name)
     @name = name
     @inventory = {}
  end

  def check_stock(item)
    if inventory[item].nil?
      0
    else
      inventory[item]
    end
  end

  def stock(item, quantity) 
    if inventory[item].nil?
      inventory[item] = quantity
    else 
      inventory[item] += quantity
    end
  end

  def potential_revenue
    inventory.reduce(0) do |sum, item|
      sum += item[0].price * item[1]
    end
  end
end