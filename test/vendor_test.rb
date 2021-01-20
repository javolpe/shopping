require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'

class VendorTest < Minitest::Test 
  def test_it_exists_and_has_attributes
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_instance_of Vendor, vendor
    assert_equal "Rocky Mountain Fresh", vendor.name 
    expected = {}
    assert_equal expected, vendor.inventory
  end

  def test_vendor_check_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})

    assert_equal 0, vendor.check_stock(item1)
  end

  def test_stock_method
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor.stock(item1, 30)
    expected = {item1 => 30}

    assert_equal expected, vendor.inventory
    assert_equal 30, vendor.check_stock(item1)

    vendor.stock(item1, 25)
    expected = {item1 => 55}

    assert_equal expected, vendor.inventory

    vendor.stock(item2, 12)

    expected = {item1 => 55,
                item2 => 12}
    
    assert_equal expected, vendor.inventory
  end
end