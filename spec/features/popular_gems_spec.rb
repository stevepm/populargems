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
    click_on 'Most liked gems'
    expect(page).to have_content('thor')
    expect(page).to have_content('12,345')
  end

  scenario 'a user can click on a gem' do
    visit '/'
    click_on 'Most liked gems'
    within '#most_hearted' do
      click_link 'thor'
    end
    expect(page).to have_content('Version Downloads')
  end


  scenario 'a user can view all popular gems based on hearts' do
    visit '/'
    click_on 'Most liked gems'
    within '#most_hearted' do
      expect(page).to have_content('Most loved gems')
    end
  end
end