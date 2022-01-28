feature 'authentication' do
  scenario 'a user can sign in' do
    # Create a test user
    User.sign_up(email: 'test@test.com', password: 'bats123')

    # Then sign in as them
    visit '/makersbnb/users/log_in'
    fill_in(:email, with: 'test@test.com')
    fill_in(:password, with: 'bats123')
    click_button('Log In!')

    expect(page).to have_content 'Welcome, test@test.com'
  end

  scenario 'a user can sign out' do
    # Create a test user
    User.sign_up(email: 'test@test.com', password: 'bats123')

    # Then sign in as them
    visit '/makersbnb/users/log_in'
    fill_in(:email, with: 'test@test.com')
    fill_in(:password, with: 'bats123')
    click_button('Log In!')

    # Sign out the user
    click_button 'Sign out'

    expect(page).not_to have_content 'Welcome, test@test.com'
    expect(page).to have_content "You have signed out"
  end

  scenario 'a user sees an error if they get their email wrong' do
    User.sign_up(email: 'test@example.com', password: 'password123')

    visit '/makersbnb/log_in'
    fill_in(:email, with: 'nottherightemail@me.com')
    fill_in(:password, with: 'password123')
    click_button('Log In!')
    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user sees an error if they get their email wrong' do
    User.sign_up(email: 'test@example.com', password: 'password123')

    visit '/makersbnb/log_in'
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'incorrectpassword')
    click_button('Log In!')

    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'Please check your email or password.'
  end
end
