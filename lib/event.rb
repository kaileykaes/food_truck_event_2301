class Event
  attr_reader :name, 
              :food_trucks
  
  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    food_trucks << food_truck
  end

  def food_truck_names
    names = []
    food_trucks.each do |food_truck|
      names << food_truck.name
    end
    names
  end

  def food_trucks_that_sell(item)
    sellers = []
    food_trucks.map do |food_truck|
      if food_truck.inventory.include?(item)
        sellers << food_truck
      end
    end
    sellers
  end 

  def total_inventory  
    errythang = {}
    food_trucks.map do |food_truck|
      food_truck.inventory.each do |item, v|
        errythang[item] = {total: 0, vendors: []} unless errythang.has_key?(item)
        errythang[item][:total] += food_truck.inventory[item]
        errythang[item][:vendors] << food_truck.name unless errythang[item].has_key?(food_truck) 
      end
    end
    errythang
  end

  def overstocked_items
    too_many = []
    total_inventory.each do |item, val|
      too_many << item if val[:total] > 50 && val[:vendors].length > 1
    end
    too_many
  end
end
