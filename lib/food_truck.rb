class FoodTruck
  attr_reader :name, 
              :inventory
  
  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
      if @inventory.include?(item)
        return @inventory[item]
      else
        @inventory[item] = 0
      end
  end 

   def stock(item, num)
    if @inventory.has_key?(item)
      @inventory[item] += num
    else 
      @inventory[item] = 0
      @inventory[item] += num
    end
  @inventory
  end
  
end
