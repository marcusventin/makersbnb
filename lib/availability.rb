require 'date'

class Availability

  def self.add_availability(name, start_date, end_date)
    @dates = Date.parse(start_date)..Date.parse(end_date)
    p @dates

    ENV['RACK_ENV'] == 'test' ? 
      connection = PG.connect(dbname: 'makersbnb_test')
      : connection = PG.connect(dbname: 'makersbnb')

    @dates.each { |date| connection.exec_params("INSERT INTO availability (name, date) VALUES ($1, $2);" [name, Date.strptime(date, '%F')]) }
  end
end
