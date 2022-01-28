feature 'add property' do
  scenario 'add a single property' do
    sign_up_and_add

    expect(page).to have_content 'test_property has been added to the site'
  end
end
