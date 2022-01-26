require 'pg'

require_relative 'availability'

class Space
  attr_reader :name, :description, :ppn

  def initialize(id:, name:, description:, ppn:)
    @id = id
    @name = name
    @description = description
    @ppn = ppn
  end

  def self.add(name:, description:, ppn:, start_date:, end_date:)
    ENV['RACK_ENV'] == 'test' ? 
      connection = PG.connect(dbname: 'makersbnb_test')
      : connection = PG.connect(dbname: 'makersbnb')

    result = connection.exec_params(
      'INSERT INTO spaces (name, description, ppn) VALUES ($1, $2, $3)
      RETURNING id, name, description, ppn;', [name, description, ppn.to_f.ceil(2)]
    )
    Availability.add_availability(name, start_date, end_date)

    Space.new(id: result[0]['id'], name: result[0]['name'],
              description: result[0]['description'], ppn: result[0]['ppn'])
  end

  def self.all
    ENV['RACK_ENV'] == 'test' ? 
    connection = PG.connect(dbname: 'makersbnb_test')
    : connection = PG.connect(dbname: 'makersbnb')

    result = connection.exec('SELECT * FROM SPACES;')

    result.map do |space| Space.new(id: space['id'], name: space['name'],
      description: space['description'], ppn: space['ppn'])
    end
  end
end