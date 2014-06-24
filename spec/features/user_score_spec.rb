require 'spec_helper'

feature 'Calculating users score' do
  scenario 'Adds and subtracts points when liking gems', js: true do
    mock_gem
    log_in
    click_on 'Most liked gems'
    within '#most_hearted' do
      click_on 'heart_faraday'
    end
    click_on 'logo'
    within '#points' do
      expect(page).to have_content('1')
    end
    click_on 'Most liked gems'
    within '#most_hearted' do
      click_on 'heart_faraday'
    end
    click_on 'user_profile'
    within '#points' do
      expect(page).to have_content('0')
    end
  end
end