feature 'User can log into to MakersBnb' do
  scenario 'User signs themselves up to MakersBnB' do
    visit('/makersbnb/log_in')

    fill_in "email", with: "landlord@rent.com"
    fill_in "password", with: "123landlord"

    click_button 'Log In!'

    # expect(page).to have_content 'Landlord'
  end
end