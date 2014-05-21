require 'spec_helper'

describe 'login with github' do
  include Capybara::DSL
  it 'can sign a user in with github' do
    log_in
    expect(page).to have_content('stevepm')
    expect(page).to have_content('Signed in!')
  end
end