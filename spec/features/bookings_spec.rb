feature 'book spaces' do
  scenario 'receives confirmation' do
    add_property
    visit '/makersbnb/properties'
    click_link('test_property')
    click_link('2022-01-26')
    click_button('submit_booking')
    expect(page).to have_content 'Your booking request has been submitted'
  end
end
