feature 'click on property' do
  scenario 'view property details' do
    add_property
    click_button 'Continue'
    # click_link 'test_property'

    expect(page).to have_content 'test description'
    expect(page).to have_content '£100.00'
  end
end