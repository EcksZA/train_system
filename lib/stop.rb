class Stop
  attr_reader :line_id, :station_id, :id

  def initialize(attributes)
    @line_id = attributes[:line_id]
    @station_id = attributes[:station_id]
    @id = attributes[:id]
  end

  def self.all
    stops = []
    results = DB.exec("SELECT * FROM stops")
    results.each do |result|
      stops << Stop.new({:line_id => result['line_id'].to_i, :station_id => result['station_id'].to_i, :id => result['id'].to_i})
    end
    stops
  end

  def save
    result = DB.exec("INSERT INTO stops (line_id, station_id) VALUES (#{self.line_id}, #{self.station_id}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(another_stop)
    self.line_id == another_stop.line_id && self.id == another_stop.id
  end

  def edit(user_line_id, user_station_id)
    DB.exec("UPDATE stops SET line_id = '#{user_line_id}', station_id = '#{user_station_id}' WHERE id = '#{self.id}';")
  end

  def delete
    DB.exec("DELETE FROM stops WHERE id = (#{self.id});")
  end
end
