require 'availability'

describe Availability do
  describe '.select_availability' do
    it 'returns an array' do
      space = Space.add(name: 'beach house', description: 'on beach', ppn: 400, start_date: '2022-02-02', end_date: '2022-04-06')
     
      dates = Availability.select_availability(space.id)
      
      expect(dates.all? { |date| date.is_a? Availability }).to eq true
    end
  end
end