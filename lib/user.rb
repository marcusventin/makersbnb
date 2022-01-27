require 'pg'

class User

  attr_reader :user_id, :user_name, :password

  def initialize(user_id:, user_name:, password:)
    @user_id = user_id
    @user_name = user_name
    @password = password
  end

  def self.sign_up(user_name:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params("INSERT INTO users (user_name, password)
    VALUES($1, $2) RETURNING user_name, password;", [user_name, password])

    User.new(user_id: result[0]['user_id'], user_name: result[0]['user_name'],
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
