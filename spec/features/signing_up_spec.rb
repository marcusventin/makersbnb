feature 'User can sign up to MakersBnb' do
  scenario 'User signs themselves up to MakersBnB' do
    visit('/makersbnb')

    click_button 'Sign Up!'
    fill_in "Name", with: "Landlord"
    fill_in "Email Address", with: "landlord@rent.com"
    fill_in "Password", with: "123landlord"

    click_button 'Submit'

    expect(page).to have_content 'Landlord'
  end
end