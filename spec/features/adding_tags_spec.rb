feature 'Adding tags' do

  scenario 'I can add a single tag to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'

    fill_in 'tag',  with: 'education'

    click_button 'Add link'
    link = Link.all
    expect(link.tags.map(&:name)).to include('education')
  end

  scenario 'I can add multiple tags to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tag',  with: 'education ruby'
    click_button 'Add link'
    link = Link.all
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end

end