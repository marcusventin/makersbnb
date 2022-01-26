feature 'User can sign up to MakersBnb' do
  scenario 'User signs themselves up to MakersBnB' do
    visit('/makersbnb')

    click_button 'Sign Up!'
    fill_in "user_name", with: "Landlord1"
    # fill_in "Email Address", with: "landlord@rent.com"
    fill_in "password", with: "123landlord"

    click_button 'Submit'

    # expect(page).to have_content 'Landlord'
  end
end
