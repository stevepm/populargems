require 'spec_helper'

describe 'commenting' do
  before do
    mock_gem
  end
  it 'a user can leave a comment if logged in' do
    log_in
    click_link 'faraday'
    within '#points' do
      expect(page).to have_content('0')
    end
    fill_in 'comment_body', with: "This is *bongos*, indeed."
    click_on 'Comment'
    within '#points' do
      expect(page).to have_content('20')
    end
    expect(page).to have_content('stevepm:')
    expect(page).to have_content('This is bongos, indeed.')
    click_on 'Delete comment'
    within '#points' do
      expect(page).to have_content('10')
    end
    expect(page).to_not have_content('This is bongos, indeed.')
    click_on 'Sign out'
    log_in
    within '#points' do
      expect(page).to have_content('10')
    end
    click_on 'Sign out'
    log_in('test')
    within '#points' do
      expect(page).to have_content('0')
    end
  end
end