require 'booking'

describe Booking do
  describe '.create' do
    it 'allows users to create a booking' do
      test_booking = Booking.create(
        date: '2022-06-06',
        owner: 'user',
        tenant: 'tenant',
        space: 'test_property',
        status: 'pending'
      )
      
      expect(test_booking).to be_a Booking
      expect(test_booking.owner).to eq 'user'
    end
  end
end
