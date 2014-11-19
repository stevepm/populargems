require 'spec_helper'

feature 'Popular gems' do
  before do
    mock_gem('thor')
  end

  scenario 'a user can click on a gem' do
    visit root_path
    click_on 'Top gems'
    click_link 'thor'
    expect(page).to have_content('Version Downloads')
  end
end