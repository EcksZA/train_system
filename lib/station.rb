class Station
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    all_stations = []
    results = DB.exec("SELECT * FROM stations")
    results.each do |result|
      all_stations << Station.new({:name => result['name'], :id => result['id'].to_i})
    end
    all_stations
  end

  def ==(another_station)
    self.name == another_station.name && self.id == another_station.id
  end

  def delete
    results = DB.exec("DELETE FROM stations WHERE id = (#{self.id});")
  end

  def change_name(update)
    DB.exec("UPDATE stations SET name = '#{update}' WHERE id = '#{self.id}'")
  end

  def lines_for_station
    lines = []
    results = DB.exec("SELECT lines.* FROM stations
                      JOIN stops ON (stations.id = stops.station_id)
                      JOIN lines ON (stops.line_id = lines.id)
                      WHERE stations.id = '#{self.id}';")
    results.each do |result|
      lines << Line.new({:name => result['name'], :id => result['id'].to_i})
    end
    lines
  end
end
