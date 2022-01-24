require 'space'

describe Space do
  describe '.add' do
    it 'add space to the database' do
      test_space = Space.add(name:'test_property',description:'test_description',ppn:100)
      expect(test_space).to be_a Space
      expect(test_space.name).to eq 'test_property'
      expect(test_space.description).to eq 'test_description'
      expect(test_space.ppn).to eq 100
    end
  end
end