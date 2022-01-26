feature 'Viewing all the properties' do
  scenario 'Listing all the properties' do
    Space.add(
      name: 'NYC Penthouse',
      description: 'Enjoy city views of Manhattan this summer!', 
      ppn: 1450, 
      start_date: '2022-06-01', 
      end_date: '2022-08-31'
    )
    Space.add(
      name: 'Brooklyn Duplex',
      description: 'Enjoy a suburban break in this wonderful duplex!', 
      ppn: 350, 
      start_date: '2022-02-01', 
      end_date: '2022-05-01'
    )

    visit ('/makersbnb/properties')

    expect(page).to have_content 'NYC Penthouse'
    expect(page).to have_content 'Brooklyn Duplex'

  end
end
