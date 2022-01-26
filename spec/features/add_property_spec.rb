feature 'add properties' do
  scenario 'add a single property' do
    visit '/add'
    fill_in 'property_name', with: 'test_property'
    fill_in 'property_description', with: 'test desciption'
    fill_in 'ppn', with: '100'
    fill_in 'start_date', with: Date.today.to_s
    fill_in 'end_date', with: (Date.today + 1).to_s
    click_button 'Add'
    
    expect(page).to have_content 'test_property added'
  end
end
