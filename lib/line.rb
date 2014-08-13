class Line
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    all_lines = []
    results = DB.exec("SELECT * FROM lines")
    results.each do |result|
      all_lines << Line.new({:name => result['name'], :id => result['id'].to_i})
    end
    all_lines
  end

  def ==(another_line)
    self.name == another_line.name && self.id == another_line.id
  end

  def delete
    DB.exec("DELETE FROM lines WHERE id = '#{self.id}'")
  end

  def change_name(update)
    DB.exec("UPDATE lines SET name='#{update}' WHERE id='#{self.id}'")
  end

  def stations_for_line
    stations = []
    results = DB.exec("SELECT stations.* FROM lines
                      JOIN stops ON (lines.id = stops.line_id)
                      JOIN stations ON (stops.station_id = stations.id)
                      WHERE lines.id = '#{self.id}';")
    results.each do |result|
      stations << Station.new(:name => result['name'], :id => result['id'].to_i)
    end
    stations
  end
end
