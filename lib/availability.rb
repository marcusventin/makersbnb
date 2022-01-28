require 'pg'
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

    result = connection.exec_params(
      "SELECT date FROM availability WHERE spaceid = ($1);", [spaceid]
    )
    
    result.map do |date| Availability.new(date: date['date'])
    end
  end

  def self.delete(booking_id)
    ENV['RACK_ENV'] == 'test' ? 
    connection = PG.connect(dbname: 'makersbnb_test')
    : connection = PG.connect(dbname: 'makersbnb')
    
    booking_data = connection.exec_params('SELECT * FROM bookings
      WHERE id = $1;', [booking_id])
    
    connection.exec_params("DELETE FROM availability
      WHERE spaceid = #{booking_data[0]['spaceid']}
      AND date = '#{booking_data[0]['date']}'")
  end
end
