require 'pry'

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
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    vendors.select do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def sorted_item_list
    item_names = vendors.map do |vendor|
      vendor.inventory.map do |name, amount|
        name
      end
    end.flatten.uniq.sort
  end

  def total_inventory
    total_amounts = Hash.new(0)
    vendors.each do |vendor|
      vendor.inventory.each do |name, amount|
        total_amounts[name] += amount
      end
    end
    total_amounts
  end

  def sell(item, qty)
    if total_inventory[item] >= qty
      sellers = vendors_that_sell(item)
      go_to_sell(sellers, 0, item, qty)
      true
    else
      false
    end
  end

  def go_to_sell(sellers, index = 0, item, qty)
    if sellers[index].inventory[item] < qty
      new_qty = (qty - sellers[index].inventory[item])
      sellers[index].inventory[item] = 0
      go_to_sell(sellers, index + 1, item, new_qty)
    else
      sellers[index].inventory[item] = sellers[index].inventory[item] - qty
    end
  end

end
