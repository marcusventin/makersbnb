require 'pg'

class Space
  attr_reader :name, :description, :ppn

  def initialize (id:, name:, description:, ppn:)
    @id = id
    @name = name
    @description = description
    @ppn = ppn
  end

  def self.add(name:, description:, ppn:)

    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params(
      'INSERT INTO spaces (name, description, ppn) VALUES ($1, $2, $3) 
      RETURNING id, name, description, ppn;', [name, description, ppn.to_f.ceil(2)])

      Space.new(id: result[0]['id'], name: result[0]['name'], 
      description: result[0]['description'], ppn: result[0]['ppn'])
  end
end
