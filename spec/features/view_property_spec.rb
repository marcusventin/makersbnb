feature 'view property' do
  scenario 'view property details' do
    sign_up_and_add
    visit('/makersbnb/spaces')
    click_link 'test_property'
    expect(page).to have_content 'test description'
    expect(page).to have_content '£100.00'
  end
end