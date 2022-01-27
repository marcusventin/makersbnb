require 'booking'
require 'user'
require 'space'

describe Booking do
  describe '.create' do
    it 'allows users to create a booking' do
      User.sign_up(user_name: 'test user 1', password: 'pass')
      User.sign_up(user_name: 'test user 2', password: 'word')
      user_result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM users')
      Space.add(name: 'test property 1', description: 'test',
        ppn: '60', start_date: Date.today.to_s, end_date: (Date.today + 1).to_s,
        ownerid: user_result[0]['user_id'])
      space_result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM spaces')

      test_booking = Booking.create(
        date: Date.today.to_s,
        spaceid: space_result[0]['id'],
        tenantid: user_result[1]['user_id'],
        status: 'pending'
      )

      expect(test_booking).to be_a Booking
      expect(test_booking.date).to eq Date.today.to_s
      expect(test_booking.space).to eq 'test property 1'
      expect(test_booking.spaceid).to eq space_result[0]['id']
      expect(test_booking.owner).to eq 'test user 1'
      expect(test_booking.ownerid).to eq user_result[0]['user_id']
      expect(test_booking.tenant).to eq 'test user 2'
      expect(test_booking.tenantid).to eq user_result[1]['user_id']
      expect(test_booking.ppn).to eq '60.00'
      expect(test_booking.status).to eq 'pending'
    end
  end
end
