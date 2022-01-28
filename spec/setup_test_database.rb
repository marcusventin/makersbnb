require 'pg'

def setup_test_database 
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec('TRUNCATE users;')
  connection.exec('TRUNCATE spaces;')
  connection.exec('TRUNCATE availability;')
  connection.exec('TRUNCATE bookings')
end

def add_user
  User.sign_up(email: 'test_user@example.com', password: 'test password')
end
