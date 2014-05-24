require 'spec_helper'

describe Heart do
  it 'can display the number of hearts for a gem' do
    faraday = mock_gem
    user = mock_user
    expect(user.hearts.length).to eq(0)
    expect(faraday.hearts.length).to eq(0)
    heart(user, faraday)
    user.reload
    faraday.reload
    expect(user.hearts.length).to eq(1)
    expect(faraday.hearts.length).to eq(1)
  end
end
