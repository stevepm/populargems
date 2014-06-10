require 'spec_helper'

feature 'User Profile' do
  scenario 'a user can view their comments', js: true do
    mock_gem
    mock_gem('rails')
    log_in
    click_on 'Most downloaded gems'
    within '#most_downloaded' do
      click_link 'faraday'
    end

    page.execute_script("editor.composer.commands.exec('insertHTML', 'This is bongos, indeed.');")

    click_on 'Comment'
    click_on 'user_profile'
    expect(page).to have_content('faraday')
    expect(page).to have_content('This is bongos, indeed.')
    within '#user_comments' do
      click_on 'faraday'
    end
    click_on 'heart_faraday'
    click_on 'heart_faraday'
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