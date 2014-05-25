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
    click_link 'faraday'
    expect(page).to have_content('stevepm:')
    expect(page).to have_content('This is bongos, indeed.')
    click_on 'vote-up'
    within '#votes' do
      expect(page).to have_content ('1')
    end
    click_link 'vote-down'
    within '#votes' do
      expect(page).to have_content ('-1')
    end
  end
end