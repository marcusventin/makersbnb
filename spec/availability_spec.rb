require 'availability'

describe Availability do
  describe '.select_availability' do
    it 'returns an array' do
      add_user
      result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM users')
      
      space = Space.add(
        name: 'beach house',
        description: 'on beach',
        ppn: 400,
        start_date: Date.today.to_s,
        end_date: (Date.today + 1).to_s,
        ownerid: result[0]['user_id']
      )
     
      dates = Availability.select_availability(space.id)
      
      expect(dates.all? { |date| date.is_a? Availability }).to eq true
    end
  end
end
