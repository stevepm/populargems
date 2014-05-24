require 'spec_helper'

feature 'Searching for a gem' do
  scenario 'user searches for faraday' do
    mock_gem
    visit '/'
    fill_in 'gem_name', with: 'faraday'
    click_on 'Search'
    expect(page).to have_content('faraday')
    expect(page).to have_content('About: search engine')
  end

  scenario 'user searches for gem that does not exist' do
    visit '/'
    VCR.use_cassette('features/searching/invalid_gem_error') do
      fill_in 'gem_name', with: 'jjkawjd'
      click_on 'Search'
    end
    expect(page).to have_content('That gem does not exist')
  end
end