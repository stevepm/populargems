require 'spec_helper'

describe 'liking gems' do
  it 'can display the number of hearts for a gem' do
    faraday = mock_gem
    user = mock_user
    expect(user.votes.for_type(PopularGem).size).to eq(0)
    expect(faraday.votes_for.by_type(User).size).to eq(0)
    user.likes faraday
    user.reload
    faraday.reload
    expect(user.votes.for_type(PopularGem).size).to eq(1)
    expect(faraday.votes_for.by_type(User).size).to eq(1)
  end
end
