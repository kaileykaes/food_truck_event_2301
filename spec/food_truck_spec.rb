require 'spec_helper'

RSpec.describe FoodTruck do
  before(:each) do
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  it 'exists and has attributes' do
    expect(@food_truck).to be_a FoodTruck
    expect(@food_truck.name).to eq("Rocky Mountain Pies")
    expect(@food_truck.inventory).to eq({})
  end

  it 'checks stock' do
    expect(@food_truck.check_stock(@item1)).to eq(0)
  end

  xit 'can stock items' do
    @food_truck.stock(@item1, 30)
    expect(food_truck.inventory).to eq({@item1 => 30})
    expect(food_truck.check_stock(@item1)).to eq(30)
  end

  xit 'can stock many items' do
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item1, 25)
    expect(food_truck.inventory).to eq({@item1 => 55})
    expect(food_truck.check_stock(@item1)).to eq(55)
  end

  xit 'can stock different items' do
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item1, 25)
    @food_truck.stock(@item2, 12)
    expect(food_truck.inventory).to eq({@item1 => 55, @item2 => 12})
  end



  
end