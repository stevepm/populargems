require 'spec_helper'

describe 'login with github' do
  include Capybara::DSL
  it 'can sign a user in with github' do
    visit '/'
    mock_auth_hash
    click_link 'Sign in with Github'
    expect(page).to have_content('Welcome stevepm')
    expect(page).to have_content('Signed in!')
  end
end