require 'pg'

class User

  attr_reader :user_id, :email, :password

  def initialize(user_id:, email:, password:)
    @user_id = user_id
    @email = email
    @password = password
  end

  def self.sign_up(email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params("INSERT INTO users (email, password)
    VALUES($1, $2) RETURNING email, password;", [email, password])

    User.new(user_id: result[0]['user_id'], email: result[0]['email'],
    password: result[0]['password'])
  end

  def self.find_id
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.query('SELECT * FROM users ORDER BY user_id DESC;')
    result[0]['user_id']
  end
end
