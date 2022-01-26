feature 'add properties' do
  scenario 'add a single property' do
    add_property

    expect(page).to have_content 'test_property added'
  end
end
