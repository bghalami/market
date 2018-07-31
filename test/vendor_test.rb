require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_attributes
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_it_returns_integer_of_item_stocked
    assert_equal 0, @vendor.check_stock("Peaches")
  end

  def test_it_can_stock_items
    assert_equal 0, @vendor.check_stock("Peaches")
    @vendor.stock("Peaches", 25)
    assert_equal 25, @vendor.check_stock("Peaches")
    @vendor.stock("Peaches", 30)
    assert_equal 55, @vendor.check_stock("Peaches")
  end


end
