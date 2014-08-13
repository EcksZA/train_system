require 'spec_helper'

describe Line do
  it 'is initialized with a name and id' do
    new_line = Line.new({:name => 'yellow'})
    expect(new_line).to be_a Line
    expect(new_line.name).to eq "yellow"
  end

  describe 'save' do
    it 'saves a line to the database' do
      new_line = Line.new({:name => 'yellow'})
      new_line.save
      expect(Line.all.length).to eq 1
    end
  end
  describe 'self.all' do
    it 'displays all lines from the database' do
      new_line = Line.new({:name => 'yellow'})
      new_line.save
      new_line2 = Line.new({:name => 'blue'})
      new_line2.save
      expect(Line.all.length).to eq 2
    end
  end

  it 'deletes a line' do
    line_1 = Line.new({:name => 'yellow'})
    line_1.save
    line_2 = Line.new({:name => 'red'})
    line_2.save
    line_1.delete
    expect(Line.all).to eq [line_2]
  end

  it "makes the same objects equal" do
    line_1 = Line.new({:name => 'yellow'})
    line_1.save
    expect(Line.all[0]).to eq line_1
  end

  it "updates the name of a line" do
    line_1 = Line.new({:name => "yellow"})
    line_1.save
    line_1.change_name("orange")
    expect(Line.all[0].name).to eq "orange"
  end

  it 'list all stations for a line' do
    new_station = Station.new({:name => 'montgomery'})
    new_station.save
    new_station2 = Station.new({:name => 'park'})
    new_station2.save
    line_1 = Line.new({:name => 'yellow'})
    line_1.save
    new_stop = Stop.new({:line_id => line_1.id, :station_id => new_station.id})
    new_stop.save
    expect(line_1.stations_for_line).to eq [new_station]
  end
end
