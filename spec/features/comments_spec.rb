require 'spec_helper'

describe 'commenting' do
  before do
    VCR.use_cassette('features/comments/create_commment') do
      mock_gem
    end
  end
  it 'a user can leave a comment if logged in' do
    visit '/'
    mock_auth_hash
    click_link 'Sign in with Github'
    click_link 'faraday'
    fill_in 'comment_body', with: "This is *bongos*, indeed."
    click_on 'Comment'
    expect(page).to have_content('stevepm:')
    expect(page).to have_content('This is bongos, indeed.')
  end
end