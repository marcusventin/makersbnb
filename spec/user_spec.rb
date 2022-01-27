require 'pg'
require 'user'
# require 'database_helpers'

describe User do
  
  describe '#sign_up' do
    it 'creates an account for the user' do
      connection = PG.connect(dbname: 'makersbnb_test')

      user1 = User.sign_up(email: 'landlord@rent.com', password: '123pass')
      # persisted_data = persisted_data(id: user1.id)

      expect(user1).to be_a User
      expect(user1.email).to eq 'landlord@rent.com'
      expect(user1.password).to eq '123pass'

    end
  end

  describe '.find' do
    it 'returns nil if there is no ID given' do
      expect(User.find(user_id: nil)).to eq nil
    end

    it 'finds a user by ID' do
      user = User.sign_up(email: 'test@example.com', password: 'password123')
      result = User.find(user_id: user.user_id)
  
      expect(result.user_id).to eq user.user_id
      expect(result.email).to eq user.email
    end
  end

  # describe '.authenticate' do
  #   it 'returns a user given a correct username and password, if one exists' do
  #     user = User.sign_up(email: 'test@example.com', password: 'password123')
  #     authenticated_user = User.authenticate('test@example.com', 'password123')
  
  #     expect(authenticated_user.user_id).to eq user.user_id
  #   end
    
  #   it 'returns nil given an incorrect email address' do
  #     user = User.sign_up(email: 'test@example.com', password: 'password123')
  
  #     expect(User.authenticate(email: 'nottherightemail@me.com', password: 'password123')).to be_nil
  #   end
    
  # end
end
