require 'spec_helper'

feature 'Popular gems' do
  before do
    mock_gem
    mock_gem('rails')
    mock_gem('rake')
    mock_gem('thor')
    mock_gem('activesupport')
    mock_gem('activerecord')
    mock_gem('actionpack')
    mock_gem('actionmailer')
    mock_gem('activemodel')
    mock_gem('activeresource')
    mock_gem('addressable')
  end
  scenario 'a user can view a gem' do
    visit '/'
    expect(page).to have_content('thor')
    expect(page).to have_content('12,345')
  end

  scenario 'a user can click on a gem' do
    visit '/'
    click_on 'thor'
    expect(page).to have_content('Version Downloads')
  end

  scenario 'a user can view all popular gems based on downloads' do
    visit '/'
    within '#most_downloaded' do
      click_on 'View more'
    end
    expect(page).to have_link('Next ›')
  end
end