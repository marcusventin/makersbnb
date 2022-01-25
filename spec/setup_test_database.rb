require 'pg'

def setup_test_database 
  p "testing the database"
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE users;")
end