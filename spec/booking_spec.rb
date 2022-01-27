require 'booking'

describe Booking do
  describe '.create' do
    it 'allows users to create a booking' do
      test_booking = Booking.create(
        date: Date.today.to_s,
        tenant: 'tenant',
        spaceid: 'test_property',
        status: 'pending'
      )
      
      expect(test_booking).to be_a Booking
      expect(test_booking.tenant).to eq 'tenant'
    end
  end
end
