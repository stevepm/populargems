require 'spec_helper'

feature 'Calculating users score' do
  scenario 'Adds and subtracts points when liking gems' do
    mock_gem
    log_in
    within '#most_downloaded' do
      click_on 'heart_faraday'
    end
    within '#points' do
      expect(page).to have_content('1')
    end
    within '#most_downloaded' do
      click_on 'heart_faraday'
    end
    within '#points' do
      expect(page).to have_content('0')
    end
  end

  scenario 'Adds and subtracts points when commenting' do
    mock_gem
    log_in
    within '#most_downloaded' do
      click_on 'faraday'
    end
    fill_in 'comment_body', with: 'this is a comment'
    click_on 'Comment'
    within '#points' do
      expect(page).to have_content('3')
    end
    click_on '[Delete comment]'
    within '#points' do
      expect(page).to have_content('0')
    end
  end

  scenario 'Adds and subtracts points to commenter when upvoting/downvoting' do
    mock_gem
    log_in('steve', '1234')
    within '#most_downloaded' do
      click_on 'faraday'
    end
    fill_in 'comment_body', with: 'this is a comment'
    click_on 'Comment'
    click_on 'Sign out'
    log_in('nekawkdkjw')
    within '#most_downloaded' do
      click_on 'faraday'
    end
    click_on 'vote-up'
    click_on 'Sign out'
    log_in('steve', '1234')
    within '#points' do
      expect(page).to have_content('13')
    end
    click_on 'Sign out'
    log_in('newjkwje')
    within '#most_downloaded' do
      click_on 'faraday'
    end
    click_on 'vote-down'
    click_on 'Sign out'
    log_in('steve', '1234')
    within '#points' do
      expect(page).to have_content('3')
    end
  end
end