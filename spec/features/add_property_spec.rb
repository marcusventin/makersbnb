
feature 'add properties' do
  scenario 'add a single property' do
    visit '/add'
    fill_in 'property_name', with: 'test_property'
    click_button 'Add'
    expect(page).to have_content 'test_property added'
  end
end