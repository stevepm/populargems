require 'spec_helper'

feature 'Root path' do
  before do
    mock_gem
    mock_gem('t')
    mock_gem('q')
    mock_gem('w')
    mock_gem('e')
    mock_gem('r')
    mock_gem('y')
    mock_gem('u')
    mock_gem('i')
    mock_gem('o')
    mock_gem('last_gem')
  end

  scenario 'shows the most recently updated gems' do
    visit root_path
    expect(page).to have_content('Recently updated gems')
    first('.next_page').click_link('Next ›')
    expect(page).to have_link('faraday')
  end
end