require 'pg'

require_relative 'availability'

class Space
  attr_reader :id, :name, :description, :ppn

  def initialize(id:, name:, description:, ppn:)
    @id = id
    @name = name
    @description = description
    @ppn = ppn
  end

  def self.add(name:, description:, ppn:, start_date:, end_date:, ownerid:)
    ENV['RACK_ENV'] == 'test' ? 
      connection = PG.connect(dbname: 'makersbnb_test')
      : connection = PG.connect(dbname: 'makersbnb')

    owner = connection.exec("SELECT * FROM users WHERE user_id = #{ownerid};")

    result = connection.exec_params(
      'INSERT INTO spaces (name, description, ppn, owner, ownerid) VALUES ($1, $2, $3, $4, $5)
      RETURNING id, name, description, ppn;', [name, description, ppn.to_f.ceil(2), owner[0]['user_name'], ownerid]
    )

    Availability.add_availability(result[0]['id'], name, start_date, end_date)

    Space.new(
      id: result[0]['id'], name: result[0]['name'],
      description: result[0]['description'], ppn: result[0]['ppn']
    )
  end

  def self.all
    ENV['RACK_ENV'] == 'test' ? 
    connection = PG.connect(dbname: 'makersbnb_test')
    : connection = PG.connect(dbname: 'makersbnb')

    result = connection.exec('SELECT * FROM spaces;')

    result.map do |space| Space.new(
      id: space['id'], name: space['name'],
      description: space['description'], ppn: space['ppn']
    )
    end
  end

  def self.select(id)
    ENV['RACK_ENV'] == 'test' ? 
    connection = PG.connect(dbname: 'makersbnb_test')
    : connection = PG.connect(dbname: 'makersbnb')

    result = connection.exec_params('SELECT * FROM spaces WHERE id = ($1);', [id])

    result.map do |space| Space.new(
      id: space['id'], name: space['name'],
      description: space['description'], ppn: space['ppn']
    )
    end
  end
end
