require 'date'

class Availability
  attr_reader :date

  def initialize(date:)
    @date = date
  end

  def self.add_availability(spaceid, name, start_date, end_date)
    @dates = (Date.parse(start_date)..Date.parse(end_date)).map { |date| date.strftime("%F") }

    ENV['RACK_ENV'] == 'test' ? 
      connection = PG.connect(dbname: 'makersbnb_test')
      : connection = PG.connect(dbname: 'makersbnb')

    @dates.each do |date| connection.exec_params("INSERT INTO availability (name, date, spaceid)
    VALUES ($1, $2, $3);", [name, date, spaceid])
    end
  end

  def self.select_availability(spaceid)
    ENV['RACK_ENV'] == 'test' ? 
      connection = PG.connect(dbname: 'makersbnb_test')
      : connection = PG.connect(dbname: 'makersbnb')

    result = connection.exec_params("SELECT date FROM availability WHERE spaceid = ($1);", [spaceid])
    result.map do |date| Availability.new(date: date['date'])
    end
  end
end
