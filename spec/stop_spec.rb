require 'spec_helper'

describe Stop do
  it 'is initialized with a list id, a station id and an id' do
    new_stop = Stop.new({:line_id => 4, :station_id => 6})
    expect(new_stop).to be_a Stop
    expect(new_stop.line_id).to eq 4
    expect(new_stop.station_id).to eq 6
  end

  it 'saves a stop to the database' do
    new_stop = Stop.new({:line_id => 4, :station_id => 6})
    new_stop.save
    expect(Stop.all).to eq [new_stop]
  end

  it 'returns all stops from the database' do
    new_stop = Stop.new({:line_id => 4, :station_id => 6})
    new_stop.save
    expect(Stop.all).to eq [new_stop]
  end

  it 'sets two objects that are the same equal' do
    new_stop = Stop.new({:line_id => 4, :station_id => 6})
    new_stop.save
    expect(Stop.all).to eq [new_stop]
  end

  it 'allows the user to edit a stops line_id and_station id' do
    new_stop = Stop.new({:line_id => 4, :station_id => 6})
    new_stop.save
    new_stop.edit(3, 5)
    expect(Stop.all[0].line_id).to eq 3
    expect(Stop.all[0].station_id).to eq 5
  end

  it 'deletes the stop' do
    new_stop = Stop.new({:line_id => 4, :station_id => 6})
    new_stop.save
    new_stop.delete
    expect(Stop.all).to eq []
  end
end

