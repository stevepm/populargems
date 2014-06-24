require 'spec_helper'

feature 'User Profile' do
  scenario 'a user can view their loved gems', js: true do
    mock_gem
    mock_gem('rails')
    log_in
    click_on 'Most liked gems'
    within '#most_hearted' do
      click_link 'faraday'
    end
    click_on 'user_profile'
    visit '/'
    click_on 'Most liked gems'
    within '#most_hearted' do
      click_on 'heart_faraday'
    end
    click_on 'user_profile'
    within '#loved_gems' do
      expect(page).to have_content('faraday')
    end
  end
end