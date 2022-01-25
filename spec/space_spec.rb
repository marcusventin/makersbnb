require 'space'
require_relative 'setup_test_database'

describe Space do
  describe '.add' do
    it 'add space to the database' do
      test_space = Space.add(name: 'test_property', description: 'test_description', ppn: 100, start_date: '2022-02-02', end_date: '2022-04-06')
      expect(test_space).to be_a Space
      expect(test_space.name).to eq 'test_property'
      expect(test_space.description).to eq 'test_description'
      expect(test_space.ppn).to eq '100.00'
    end
  end

  describe '.all' do
    it 'displays all spaces' do
      setup_test_database
    test_space = Space.add(name: 'test_property', description: 'test_description', ppn: 100, start_date: '2022-02-02', end_date: '2022-04-06')
    Space.add(name:'beach house', description:'on beach', ppn: 400, start_date: '2022-02-02', end_date: '2022-04-06')
    all_spaces = Space.all
    expect(all_spaces.first.name).to eq 'test_property'
    expect(all_spaces.last.description).to eq 'on beach'
    expect(all_spaces.length).to eq 2
    end
  end


      
end
