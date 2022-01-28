require 'pg'
require 'user'
# require 'database_helpers'

describe User do
  
  describe '#sign_up' do
    it 'creates an account for the user' do
      connection = PG.connect(dbname: 'makersbnb_test')

      user1 = User.sign_up(email: 'landlord@example.com', password: '123pass')
      # persisted_data = persisted_data(id: user1.id)

      expect(user1).to be_a User
      expect(user1.email).to eq 'landlord@example.com'
      expect(user1.password).to eq '123pass'

    end
  end

end
