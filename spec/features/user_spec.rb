require 'spec_helper'

feature 'User Profile' do
  scenario 'a user can view their comments', js: true do
    mock_gem
    mock_gem('rails')
    log_in
    within '#most_downloaded' do
      click_link 'faraday'
    end
    fill_in 'comment_body', with: "This is *bongos*, indeed."
    click_on 'Comment'
    click_on 'user_profile'
    expect(page).to have_content('faraday')
    expect(page).to have_content('This is bongos, indeed.')
    click_on 'faraday'
    click_on 'heart_faraday'
    click_on 'heart_faraday'
    visit '/'
    within '#most_hearted' do
      click_on 'heart_faraday'
    end
    click_on 'user_profile'
    within '#loved_gems' do
      expect(page).to have_content('Loved Gems')
      expect(page).to have_content('faraday')
    end
  end
end