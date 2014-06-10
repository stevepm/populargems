require 'spec_helper'
require_relative '../../config/initializers/no_timestamps'

describe 'Not using timestamps' do
  it 'will like a gem without updating the gems timestamp' do
    gem = mock_gem
    timestamp = gem.updated_at
    user = mock_user
    sleep(5)
    PopularGem.without_timestamps do
      user.likes gem
    end
    expect(timestamp).to eq(gem.updated_at)
  end
end
