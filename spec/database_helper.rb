require 'pg'

# def persisted_data(id:)
#   connection = PG.connect(dbname: 'makersbnb_test')
#   result = connection.query("SELECT * FROM users WHERE id = #{id};")
#   result.first
# end

def add_property
  visit '/makersbnb/add'
  fill_in 'property_name', with: 'test_property'
  fill_in 'property_description', with: 'test description'
  fill_in 'ppn', with: '100'
  fill_in 'start_date', with: Date.today.to_s
  fill_in 'end_date', with: (Date.today + 1).to_s
  click_button 'Add'
end
