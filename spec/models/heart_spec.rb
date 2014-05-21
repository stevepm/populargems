require 'spec_helper'

describe Heart do
  it 'can display the number of hearts for a gem' do
    VCR.use_cassette('models/hearts/add_heart') do
      mock_gem
    end
    faraday = PopularGem.find_by_name('faraday')
    user = mock_user
    Heart.create(user: user, popular_gem: faraday)
    expect(user.hearts.length).to eq(1)
    expect(faraday.hearts.length).to eq(1)
  end
end
