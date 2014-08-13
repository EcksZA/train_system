require 'spec_helper'

describe Station do
  it 'is initialized with a name and an id' do
    new_station = Station.new({:name => 'montgomery'})
  expect(new_station).to be_a Station
  expect(new_station.name).to eq 'montgomery'
  end

  it 'is saves a station to the database' do
    new_station = Station.new({:name => 'montgomery'})
    new_station.save
    expect(Station.all.length).to eq 1
  end

  it 'deletes a station for the database' do
    new_station = Station.new({:name => 'montgomery'})
    new_station.save
    new_station2 = Station.new({:name => 'park'})
    new_station2.save
    new_station.delete
    expect(Station.all).to eq [new_station2]
  end

  it 'makes two objects with matching attributes equal' do
    new_station = Station.new({:name => 'montgomery'})
    new_station.save
    expect(Station.all[0]).to eq new_station
  end

  it "updates the name of a station" do
    station_1 = Station.new({:name => "montgomery"})
    station_1.save
    station_1.change_name("park")
    expect(Station.all[0].name).to eq "park"
  end

  it "lists out all the lines for a particular station" do
    new_station = Station.new({:name => 'montgomery'})
    new_station.save
    line_1 = Line.new({:name => 'yellow'})
    line_1.save
    line_2 = Line.new({:name => 'green'})
    line_2.save
    new_stop = Stop.new({:line_id => line_2.id, :station_id => new_station.id})
    new_stop.save
    expect(new_station.lines_for_station).to eq [line_2]
  end
end
