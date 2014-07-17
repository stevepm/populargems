require 'spec_helper'

describe UpdatedStat do
  it 'can add a new stat to created_stat' do
    UpdatedStat.create(count: 242)
    expect(UpdatedStat.last.count).to eq(242)
    expect(UpdatedStat.last.created_at).to be > 1.day.ago
  end
  it 'can return all of the stats for the last 30 days' do
    one = UpdatedStat.create(count: rand(300), created_at: 1.day.ago)
    two = UpdatedStat.create(count: rand(300), created_at: 2.day.ago)
    three = UpdatedStat.create(count: rand(300), created_at: 29.day.ago)
    UpdatedStat.create(count: rand(300), created_at: 31.day.ago)
    expect(UpdatedStat.recent_stats_hash).to eq({one.created_at => one.count, two.created_at => two.count, three.created_at => three.count})
  end
end