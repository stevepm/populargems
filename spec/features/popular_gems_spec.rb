require 'spec_helper'

feature 'Popular gems' do
  before do
    VCR.use_cassette('features/popular_gem/view_gem') do
      mock_gem
    end
  end
  scenario 'a user can view a gem' do
    visit '/'
    expect(page).to have_content('faraday')
    expect(page).to have_content('HTTP/REST API client library.')
    expect(page).to have_content('8723613')
  end

  scenario 'a user can click on a gem' do
    visit '/'
    click_on 'faraday'
    expect(page).to have_content('Version Downloads')
  end
end