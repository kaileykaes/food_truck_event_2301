require 'spec_helper'
require 'date'
RSpec.describe Event do
  before(:each) do
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({
      name: 'Peach Pie (Slice)', 
      price: "$3.75"
      })
    @item2 = Item.new({
      name: 'Apple Pie (Slice)', 
      price: '$2.50'
      })
    @item3 = Item.new({
      name: "Peach-Raspberry Nice Cream", 
      price: "$5.30"
    })
    @item4 = Item.new({
      name: "Banana Nice Cream", 
      price: "$4.25"
      })
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7) 
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
  end

  it 'exists & has attr' do
    expect(@event).to be_a Event
    expect(@event.name).to eq("South Pearl Street Farmers Market")
    expect(@event.food_trucks).to eq([])
  end

  it 'adds food trucks' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
  end

  it 'lists food truck names' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it 'lists food trucks that sell' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
    expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
  end
  
  it 'trucks have potential revenue' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@food_truck1.potential_revenue).to eq(148.75)
    expect(@food_truck2.potential_revenue).to eq(345.00)
    expect(@food_truck3.potential_revenue).to eq(243.75)
  end

  it 'can check total inventory' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.total_inventory).to be_a(Hash)
    expect(@event.total_inventory).to eq({
      @item1 => {total: 100, food_trucks: ["Rocky Mountain Pies", "Palisade Peach Shack"]},
      @item2 => {total:7, food_trucks: ["Rocky Mountain Pies"]},
      @item3 => {total: 25, food_trucks: ["Ba-Nom-a-Nom"]},
      @item4 => {total: 50, food_trucks: ["Ba-Nom-a-Nom"]}
      })
  end 

  it 'finds overstocked items' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    @event.total_inventory
    expect(@event.overstocked_items).to eq([@item1])
  end

  it 'can create a sorted item list' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.sorted_item_list).to be_a Array
    expect(@event.sorted_item_list).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
  end

  it 'has a date' do
    expect(@event.date).to be_a Date
  end

  it 'can sell items' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.sell(@item1, 15)).to eq(true)
    expect(@food_truck1.inventory).to eq({@item1 => 20, @item2 => 7})
    expect(@event.total_inventory).to eq({
      @item1 => {total: 85, food_trucks: ["Rocky Mountain Pies", "Palisade Peach Shack"]},
      @item2 => {total:7, food_trucks: ["Rocky Mountain Pies"]},
      @item3 => {total: 25, food_trucks: ["Ba-Nom-a-Nom"]},
      @item4 => {total: 50, food_trucks: ["Ba-Nom-a-Nom"]}
      })
    expect(@event.sell(@item2, 30)).to eq(false)
  end

  it 'can sell items from multiple trucks' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.sell(@item1, 70)).to be true
    expect(@food_truck1.inventory).to eq({@item1 => 0, @item2 => 7})
    expect(@event.total_inventory).to eq({
      @item1 => {total: 30, food_trucks: ["Palisade Peach Shack"]},
      @item2 => {total:7, food_trucks: ["Rocky Mountain Pies"]},
      @item3 => {total: 25, food_trucks: ["Ba-Nom-a-Nom"]},
      @item4 => {total: 50, food_trucks: ["Ba-Nom-a-Nom"]}
      })
  end
end