require 'pg'

class Booking
  attr_reader :id, :date, :space, :spaceid, :owner, :ownerid, :tenant, :tenantid, :ppn, :status

  def initialize(id:, date:, space:, spaceid:, owner:, ownerid:, tenant:, tenantid:, ppn:, status:)
    @id = id
    @date = date
    @space = space
    @spaceid = spaceid
    @owner = owner
    @ownerid = ownerid
    @tenant = tenant
    @tenantid = tenantid
    @ppn = ppn
    @status = status
  end

  def self.create(date:, spaceid:, tenantid:, status:)
    ENV['RACK_ENV'] == 'test' ? 
    connection = PG.connect(dbname: 'makersbnb_test')
    : connection = PG.connect(dbname: 'makersbnb')

    space_data = connection.exec_params(
      'SELECT * FROM spaces WHERE id = ($1);', [spaceid]
    )

    tenant_data = connection.exec_params(
      'SELECT * FROM users WHERE user_id = ($1);', [tenantid]
    )

    result = connection.exec_params(
      "INSERT INTO bookings (date, space, spaceid, owner, ownerid,
      tenant, tenantid, ppn, status)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
      RETURNING id, date, space, spaceid, owner, ownerid, tenant, tenantid, ppn, status;",
      [date, space_data[0]['name'], spaceid, space_data[0]['owner'],
      space_data[0]['ownerid'], tenant_data[0]['email'],
      tenantid, space_data[0]['ppn'], status]
    )

    Booking.new(
      id: result[0]['id'], date: result[0]['date'], space: result[0]['space'],
      spaceid: result[0]['spaceid'], owner: result[0]['owner'], 
      ownerid: result[0]['ownerid'], tenant: result[0]['tenant'],
      tenantid: result[0]['tenantid'], ppn: result[0]['ppn'], status: result[0]['status']
    )
  end

  def self.view_pending(user_id)
    ENV['RACK_ENV'] == 'test' ?
    connection = PG.connect(dbname: 'makersbnb_test')
    : connection = PG.connect(dbname: 'makersbnb')

    result = connection.exec_params("SELECT * FROM bookings WHERE ownerid = $1
      AND status LIKE 'pending';", [user_id])

    result.map do |result| Booking.new(
      id: result['id'], date: result['date'], space: result['space'],
      spaceid: result['spaceid'], owner: result['owner'], 
      ownerid: result['ownerid'], tenant: result['tenant'],
      tenantid: result['tenantid'], ppn: result['ppn'], status: result['status']
    )
    end
  end

  def self.view_confirmed(user_id)
    ENV['RACK_ENV'] == 'test' ?
    connection = PG.connect(dbname: 'makersbnb_test')
    : connection = PG.connect(dbname: 'makersbnb')
  
    result = connection.exec_params("SELECT * FROM bookings WHERE ownerid = $1
      AND status LIKE 'confirmed';", [user_id])
  
    result.map do |result| Booking.new(
      id: result['id'], date: result['date'], space: result['space'],
      spaceid: result['spaceid'], owner: result['owner'], 
      ownerid: result['ownerid'], tenant: result['tenant'],
      tenantid: result['tenantid'], ppn: result['ppn'], status: result['status']
      )
    end
  end

  def self.confirm(booking_id)
    ENV['RACK_ENV'] == 'test' ?
    connection = PG.connect(dbname: 'makersbnb_test')
    : connection = PG.connect(dbname: 'makersbnb')
    
    connection.exec_params(
      "UPDATE bookings SET status='confirmed'
      WHERE id = $1", [booking_id]
    )
    
    Availability.delete(booking_id)

  end

  def self.decline(booking_id)
    ENV['RACK_ENV'] == 'test' ?
    connection = PG.connect(dbname: 'makersbnb_test')
    : connection = PG.connect(dbname: 'makersbnb')
    
    connection.exec_params(
      "UPDATE bookings SET status='declined'
      WHERE id = $1", [booking_id]
    )
  end
end
