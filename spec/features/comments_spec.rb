require 'spec_helper'

describe 'commenting' do
  before do
    mock_gem
  end
  it 'a user can leave a comment if logged in' do
    log_in
    click_link 'faraday'
    fill_in 'comment_body', with: "This is *bongos*, indeed."
    click_on 'Comment'
    expect(page).to have_content('stevepm:')
    expect(page).to have_content('This is bongos, indeed.')
    click_on 'Delete comment'
    expect(page).to_not have_content('This is bongos, indeed.')
  end
end