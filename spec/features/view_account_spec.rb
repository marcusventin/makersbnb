feature 'view account' do
  scenario 'it shows list of properties' do
    User.sign_up(email: '1@@example.com', password: 'test password 1')
    visit '/makersbnb/users/sign_up'
    fill_in 'email', with: '2@example.com'
    fill_in 'password', with: 'test password 2'
    click_button 'Submit'
    result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM users')
    
    Space.add(
      name: 'test property',
      description: 'test description',
      ppn: '30',
      start_date: Date.today.to_s,
      end_date: (Date.today + 1).to_s,
      ownerid: result[1]['user_id']
    )

    visit "/makersbnb/users/#{result[1]['user_id']}"
    expect(page).to have_content 'test property'
  end 
end
