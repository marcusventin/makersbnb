require 'pg'
require 'user'
require 'bcrypt'
# require 'database_helpers'

describe User do
  
  describe '.sign_up' do
    it 'creates an account for the user' do
      connection = PG.connect(dbname: 'makersbnb_test')

      user1 = User.sign_up(email: 'landlord@rent.com', password: 'password123')

      expect(user1).to be_a User
      expect(user1.email).to eq 'landlord@rent.com'
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password123')
      User.sign_up(email: 'landlord@rent.com', password: 'password123')
    end
  end

  describe '.find' do
    it 'returns nil if there is no ID given' do
      expect(User.find(user_id: nil)).to eq nil
    end

    it 'finds a user by ID' do
      user = User.sign_up(email: 'landlord@rent.com', password: 'password123')
      result = User.find(user_id: user.user_id)
  
      expect(result.user_id).to eq user.user_id
      expect(result.email).to eq user.email
    end
  end

  describe '.authenticate' do
    it 'returns a user given a correct username and password, if one exists' do
      user = User.sign_up(email: 'landlord@rent.com', password: 'password123')
      authenticated_user = User.authenticate(email: 'landlord@rent.com', password: 'password123')
  
      expect(authenticated_user.user_id).to eq user.user_id
    end
    
    it 'returns nil given an incorrect email address' do
      user = User.sign_up(email: 'landlord@rent.com', password: 'password123')
  
      expect(User.authenticate(email: 'nottherightemail@me.com', password: 'password123')).to be_nil
    end

    it 'returns nil given an incorrect password' do
      user = User.sign_up(email: 'test@example.com', password: 'password123')
  
      expect(User.authenticate(email: 'test@example.com', password: 'wrongpassword')).to be_nil
    end
    
  end
end
