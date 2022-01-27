require 'pg'

def setup_test_database 
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec('TRUNCATE users;')
  connection.exec('TRUNCATE spaces;')
  connection.exec('TRUNCATE availability;')
  connection.exec('TRUNCATE bookings')
end

def add_user
  User.sign_up(user_name: 'test user', password: 'test password')
end
