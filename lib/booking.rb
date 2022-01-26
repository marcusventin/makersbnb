require 'pg'

class Booking
  attr_reader :id, :date, :owner, :tenant, :space, :status

  def initialize(id:, date:, owner:, tenant:, space:, status:)
    @id = id
    @date = date
    @owner = owner
    @tenant = tenant
    @space = space
    @status = status
  end

  def self.create(date:, owner:, tenant:, space:, status:)
    ENV['RACK_ENV'] == 'test' ? 
    connection = PG.connect(dbname: 'makersbnb_test')
    : connection = PG.connect(dbname: 'makersbnb')

    result = connection.exec_params(
      "INSERT INTO bookings (date, owner, tenant, space, status)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING id, date, owner, tenant, space, status;",
      [date, owner, tenant, space, status]
    )

    Booking.new(id: result[0]['id'], date: result[0]['date'], owner: result[0]['owner'],
    tenant: result[0]['tenant'], space: result[0]['space'], status: result[0]['status'])
  end
end
