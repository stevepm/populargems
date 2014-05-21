require 'spec_helper'

feature 'User Profile' do
  scenario 'a user can view their comments' do
    VCR.use_cassette('features/user/view_comments') do
      mock_gem
    end
    log_in
    click_on 'faraday'
    fill_in 'comment_body', with: "This is *bongos*, indeed."
    click_on 'Comment'
    click_on 'stevepm'
    expect(page).to have_content('faraday')
    expect(page).to have_content('This is bongos, indeed.')
  end
end