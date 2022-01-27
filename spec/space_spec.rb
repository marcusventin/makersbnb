require 'space'

describe Space do
  describe '.add' do
    it 'adds a space to the database' do
      test_space = Space.add(
        name: 'test_property',
        description: 'test_description',
        ppn: 100,
        start_date: Date.today.to_s,
        end_date: (Date.today + 1).to_s
      )

      expect(test_space).to be_a Space
      expect(test_space.name).to eq 'test_property'
      expect(test_space.description).to eq 'test_description'
      expect(test_space.ppn).to eq '100.00'
    end
  end

  describe '.all' do
    it 'displays all spaces' do
      test_space = Space.add(
        name: 'test_property',
        description: 'test_description',
        ppn: 100,
        start_date: Date.today.to_s,
        end_date: (Date.today + 1).to_s
      )
      Space.add(
        name: 'beach house',
        description: 'on beach',
        ppn: 400,
        start_date: Date.today.to_s,
        end_date: (Date.today + 1).to_s
      )
      all_spaces = Space.all

      expect(all_spaces.first.name).to eq 'test_property'
      expect(all_spaces.last.description).to eq 'on beach'
      expect(all_spaces.length).to eq 2
    end
  end   

  describe '.select' do
    it "returns a space's attributes" do
      space = Space.add(
        name: 'test_property',
        description: 'test_description',
        ppn: 100,
        start_date: Date.today.to_s,
        end_date: (Date.today + 1).to_s
      )
      
      persisted_data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM spaces WHERE id = #{space.id}")
      
      selected = Space.select(persisted_data.first['id'])

      expect(selected[0]).to be_a Space
      expect(selected[0].name).to eq 'test_property'
      expect(selected[0].description).to eq 'test_description'
      expect(selected[0].ppn).to eq '100.00'
    end
  end
end
