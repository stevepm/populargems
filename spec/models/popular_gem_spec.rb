require 'spec_helper'

describe PopularGem do
  let (:faraday) {mock_gem('faraday', 9000)}
  let (:rails) {mock_gem('rails', 8000)}
  let (:test) {mock_gem('test', 7000)}
  let (:stevepm) {mock_user}
  let (:john) {mock_user('john')}
  let (:adam) {mock_user('adam')}
  it 'can return the top downloaded gems in an array' do
    expect(PopularGem.top_downloaded(2)).to eq([faraday, rails])
  end

  it 'can return the top hearted gems in an array' do
    stevepm.likes faraday
    stevepm.likes rails
    stevepm.likes test
    john.likes test
    john.likes rails
    adam.likes test
    expect(PopularGem.order('cached_votes_score').reverse[0..1]).to eq([test, rails])
  end

  it 'can return the number gems created in the last day' do
    faraday
    rails
    test
    expect(faraday.created_at).to be >= 1.day.ago
    expect(rails.created_at).to be >= 1.day.ago
    expect(test.created_at).to be >= 1.day.ago
    expect(PopularGem.created_yesterday).to eq(3)
    test.update(created_at: 2.days.ago)
    expect(test.created_at).to be <= 2.day.ago
    expect(PopularGem.created_yesterday).to eq(2)
  end

  it 'can return the number of gems updated in the last day' do
    faraday
    rails
    test
    expect(faraday.updated_at).to be >= 1.day.ago
    expect(rails.updated_at).to be >= 1.day.ago
    expect(test.updated_at).to be >= 1.day.ago
    expect(PopularGem.updated_yesterday).to eq(0)
    faraday.update(updated_at: 2.days.ago, created_at: 2.days.ago)
    test.update(created_at: 2.days.ago)
    expect(PopularGem.updated_yesterday).to eq(1)
  end

  it 'can create stat logs for most recently updated and most recently created' do
    faraday
    rails
    test
    test.update(created_at: 2.days.ago)
    PopularGem.create_stat_logs
    expect(CreatedStat.recent_stats_hash.first[1]).to eq(2)
    expect(UpdatedStat.recent_stats_hash.first[1]).to eq(1)
  end
end