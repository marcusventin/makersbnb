feature 'view account' do
  scenario 'it shows list of properties' do
    visit '/makersbnb/users/sign_up'
    fill_in 'email', with: '1@example.com'
    fill_in 'password', with: 'test password 1'
    click_button 'Submit'
    result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM users')
    
    Space.add(
      name: 'test property',
      description: 'test description',
      ppn: '30',
      start_date: Date.today.to_s,
      end_date: (Date.today + 1).to_s,
      ownerid: result[0]['user_id']
    )

    visit "/makersbnb/users/#{result[0]['user_id']}"
    expect(page).to have_content 'test property'
  end

  scenario 'it shows list of pending bookings' do
    visit '/makersbnb/users/sign_up'
    fill_in 'email', with: 'owner@example.com'
    fill_in 'password', with: 'test password 1'
    click_button 'Submit'
    owner_result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM users')

    Space.add(
      name: 'test property',
      description: 'test description',
      ppn: '30',
      start_date: Date.today.to_s,
      end_date: (Date.today + 1).to_s,
      ownerid: owner_result[0]['user_id']
    )
    space_result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM spaces')
    
    User.sign_up(email: 'tenant@@example.com', password: 'test password 1')
    user_result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM users')
    
    Booking.create(
      date: Date.today.to_s,
      spaceid: space_result[0]['id'],
      tenantid: user_result[1]['user_id'],
      status: 'pending'
    )
  
    visit "/makersbnb/users/#{user_result[0]['user_id']}"
    expect(page).to have_button 'Confirm Booking'
  end

  scenario 'confirm pending booking' do
    visit '/makersbnb/users/sign_up'
    fill_in 'email', with: 'owner@example.com'
    fill_in 'password', with: 'test password 1'
    click_button 'Submit'
    owner_result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM users')

    Space.add(
      name: 'test property',
      description: 'test description',
      ppn: '30',
      start_date: Date.today.to_s,
      end_date: (Date.today + 1).to_s,
      ownerid: owner_result[0]['user_id']
    )
    space_result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM spaces')
    
    User.sign_up(email: 'tenant@example.com', password: 'test password 1')
    user_result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM users')
    
    Booking.create(
      date: Date.today.to_s,
      spaceid: space_result[0]['id'],
      tenantid: user_result[1]['user_id'],
      status: 'pending'
    )
  
    visit "/makersbnb/users/#{user_result[0]['user_id']}"
    click_button 'Confirm Booking'
    expect(page).not_to have_button 'Confirm Booking'
  end

  scenario 'declining a booking request removes it from account page' do
    visit '/makersbnb/users/sign_up'
    fill_in 'email', with: 'owner@example.com'
    fill_in 'password', with: 'test password 1'
    click_button 'Submit'
    owner_result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM users')

    Space.add(
      name: 'test property',
      description: 'test description',
      ppn: '30',
      start_date: Date.today.to_s,
      end_date: (Date.today + 1).to_s,
      ownerid: owner_result[0]['user_id']
    )
    space_result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM spaces')
    
    User.sign_up(email: 'tenant@example.com', password: 'test password 1')
    user_result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM users')
    
    Booking.create(
      date: Date.today.to_s,
      spaceid: space_result[0]['id'],
      tenantid: user_result[1]['user_id'],
      status: 'pending'
    )
  
    visit "/makersbnb/users/#{user_result[0]['user_id']}"
    click_button 'Decline Request'
    expect(page).not_to have_button 'Confirm Booking'
    expect(page).not_to have_content Date.today.to_s
  end
end
