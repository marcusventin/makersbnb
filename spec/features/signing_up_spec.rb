feature 'User can sign up to MakersBnb' do
  scenario 'User signs themselves up to MakersBnB' do
    visit('/makersbnb/sign_up')

    fill_in 'email', with: "landlord@rent.com"
    fill_in 'password', with: 'newpassword1'

    click_button 'Submit'
    # expect(page).to have_content 'Landlord'
  end
end
