feature 'book spaces' do
  scenario 'receives confirmation' do
    add_property
    visit '/makersbnb/spaces'
    click_link('test_property')
    click_link(Date.today.to_s)
    click_button('submit_booking')
    expect(page).to have_content 'Your booking request has been submitted'
  end
end
