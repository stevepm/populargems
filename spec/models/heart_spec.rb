require 'spec_helper'

describe Heart do
  it 'can display the number of hearts for a gem' do
    mock_gem
    faraday = PopularGem.find_by_name('faraday')
    user = mock_user
    heart(user, faraday)
    expect(user.hearts.length).to eq(1)
    expect(faraday.hearts.length).to eq(1)
  end
end
