feature "view account" do
scenario "it shows list of bookings" do
  User.sign_up(user_name: 'test user 1', password: 'test password 1')
  visit "/makersbnb/sign_up"
  fill_in "user_name", with: "test user 2"
  fill_in "password", with: "test password 2"
  click_button "Submit"
  result = PG.connect(dbname: 'makersbnb_test').exec('SELECT * FROM users')
  Space.add(name: "test property", description: "test discription", ppn: "£30", start_date: Date.today.to_s, end_date:(Date.today + 1).to_s, ownerid: result[0]['user_id'])
  visit "/makersbnb/#{result[0]['user_id']}"
  expect(page).to have_content "test property"
end 
end 

