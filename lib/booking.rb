require 'pg'

class Booking
  attr_reader :id, :date, :tenant, :spaceid, :status

  def initialize(id:, date:, tenant:, spaceid:, status:)
    @id = id
    @date = date
    @tenant = tenant
    @spaceid = spaceid
    @status = status
  end

  def self.create(date:, tenant:, spaceid:, status:)
    ENV['RACK_ENV'] == 'test' ? 
    connection = PG.connect(dbname: 'makersbnb_test')
    : connection = PG.connect(dbname: 'makersbnb')

    result = connection.exec_params(
      "INSERT INTO bookings (date, tenant, spaceid, status)
      VALUES ($1, $2, $3, $4)
      RETURNING id, date, tenant, spaceid, status;",
      [date, tenant, spaceid, status]
    )

    Booking.new(
      id: result[0]['id'], date: result[0]['date'], tenant: result[0]['tenant'],
      spaceid: result[0]['spaceid'], status: result[0]['status']
    )
  end
end
