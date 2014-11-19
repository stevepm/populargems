require 'spec_helper'

feature 'Calculating users score' do
  before do
    mock_gem
  end
  scenario 'Adds and subtracts points when liking gems', js: true do
    log_in
    within '#recently_updated' do
      click_on 'faraday'
    end
    click_on 'heart_faraday'
    click_on 'logo'
    within '#points' do
      expect(page).to have_content('1')
    end
    within '#recently_updated' do
      click_on 'faraday'
    end
    click_on 'heart_faraday'
    click_on 'logo'
    within '#points' do
      expect(page).to have_content('0')
    end
  end
end