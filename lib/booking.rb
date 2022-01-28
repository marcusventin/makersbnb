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
    #   "INSERT INTO bookings (date, space, spaceid, owner, ownerid,
    #   tenant, tenantid, ppn, status)
    #   SELECT name, owner, ownerid, ppn
    #   FROM spaces
    #   WHERE spaces.id = $2
    #   SELECT 
    #   ($1,
    #   SELECT name FROM spaces WHERE spaces.id = $2,
    #   $2,
    #   SELECT owner FROM spaces WHERE spaces.id = $2,
    #   SELECT ownerid FROM spaces WHERE spaces.id = $2,
    #   SELECT user_name FROM users WHERE users.user_id = $3,
    #   $3,
    #   SELECT ppn FROM spaces WHERE spaces.id = $2,
    #   $4)
    #   RETURNING id, date, space, spaceid, owner, ownerid, tenant, tenantid, ppn, status;",
    #   [date, spaceid, tenantid, status]
    # )
      

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
end
