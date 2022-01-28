require 'pg'
require 'bcrypt'

class User

  attr_reader :user_id, :email , :password

  def initialize(user_id:, email:, password:)
    @user_id = user_id
    @email = email 
    @password = password
  end

  def self.sign_up(email:, password:)
    # encrypt the plantext password
    encrypted_password = (BCrypt::Password).create(password)

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

     # insert the encrypted password into the database, instead of the plaintext one
    result = connection.exec_params("INSERT INTO users (email, password) VALUES($1, $2) RETURNING user_id, email;", [email , encrypted_password])

    User.new(user_id: result[0]['user_id'], email: result[0]['email'], password: result[0]['password'])
  end

  def self.find(user_id:)
    return nil unless user_id
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    
    result = connection.exec_params("SELECT * FROM users WHERE user_id = $1", [user_id])
    
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
