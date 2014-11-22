require 'spec_helper'

feature 'User Profile' do
  before do
    mock_gem
  end
  scenario 'a user can view their loved gems', js: true do
    log_in
    within("#recently_updated_gems") do
      click_on 'faraday'
    end
    click_on 'heart_faraday'
    click_on 'user_profile'
    within '#loved_gems' do
      expect(page).to have_content('faraday')
    end
  end
end