# feature 'authentication' do
#   scenario 'a user can sign in' do
#     # Create a test user
#     User.sign_up(email: 'test@example.com', password: 'password123')

#     # Then sign in as them
#     visit '/makersbnb/log_in'
#     fill_in(:email, with: 'test@example.com')
#     fill_in(:password, with: 'password123')
#     click_button('Log In!')

#     expect(page).to have_content 'Welcome, test@example.com'
#   end

#   scenario 'a user sees an error if they get their email wrong' do
#     User.sign_up(email: 'test@example.com', password: 'password123')

#     visit '/makersbnb/log_in'
#     fill_in(:email, with: 'nottherightemail@me.com')
#     fill_in(:password, with: 'password123')
#     click_button('Log In!')

#     expect(page).not_to have_content 'Welcome, test@example.com'
#     expect(page).to have_content 'Please check your email or password.'
#   end
# end