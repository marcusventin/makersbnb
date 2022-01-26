feature 'add properties' do
  scenario 'add a single property' do
    add_property
    visit('/makersbnb')
    click_link 'Properties'
    expect(page).to have_content 'test_property has been added to the site'
  end
end
