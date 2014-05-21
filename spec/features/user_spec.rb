require 'spec_helper'

feature 'User Profile' do
  scenario 'a user can view their comments' do
    log_in
    mock_gem
    click_on 'faraday'
    fill_in 'comment_body', with: "This is *bongos*, indeed."
    click_on 'Comment'
    click_on 'stevepm'
    expect(page).to have_content('faraday')
    expect(page).to have_content('This is bongos, indeed.')
  end
end