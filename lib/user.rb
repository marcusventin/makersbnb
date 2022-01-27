require 'pg'

class User

  attr_reader :user_id, :email , :password

  def initialize(user_id:, email:, password:)
    @user_id = user_id
    @email  = email 
    @password = password
  end

  def self.sign_up(email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params("INSERT INTO users (email, password) VALUES($1, $2) RETURNING email , password;", [email , password])

    User.new(user_id: result[0]['user_id'], email: result[0]['email'], password: result[0]['password'])
  end

  # def self.authenticate(email:, password:)
  #   result = DatabaseConnection.query(
  #     "SELECT * FROM users WHERE email = $1",
  #     [email]
  #   )
  #   return unless result.any?

  #   User.new(result[0]['user_id'], result[0]['email'])
  # end


end
