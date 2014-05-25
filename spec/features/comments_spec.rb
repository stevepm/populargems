require 'spec_helper'

describe 'commenting' do
  before do
    mock_gem
  end
  it 'a user can leave a comment if logged in' do
    log_in
    within '#most_downloaded' do
      click_link 'faraday'
    end
    within '#points' do
      expect(page).to have_content('0')
    end
    fill_in 'comment_body', with: "This is *bongos*, indeed."
    click_on 'Comment'
    within '#points' do
      expect(page).to have_content('3')
    end
    expect(page).to have_content('stevepm:')
    expect(page).to have_content('This is bongos, indeed.')
    click_on 'Delete comment'
    within '#points' do
      expect(page).to have_content('0')
    end
    expect(page).to_not have_content('This is bongos, indeed.')
    fill_in 'comment_body', with: "This is *bongos*, indeed."
    click_on 'Comment'
    click_on 'Sign out'
    log_in('test')
    within '#most_downloaded' do
      click_link 'faraday'
    end
    expect(page).to have_content('stevepm:')
    expect(page).to have_content('This is bongos, indeed.')
    expect(page).to have_link 'vote-up'
    expect(page).to have_link 'vote-down'
  end
end