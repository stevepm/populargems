require 'spec_helper'

describe CreatedStat do
  it 'can add a new stat to created_stat' do
    CreatedStat.create(count: 242)
    expect(CreatedStat.last.count).to eq(242)
    expect(CreatedStat.last.created_at).to be > 1.day.ago
  end
  it 'can return all of the stats for the last 30 days' do
    one = CreatedStat.create(count: rand(300), created_at: 1.day.ago)
    two = CreatedStat.create(count: rand(300), created_at: 2.day.ago)
    three = CreatedStat.create(count: rand(300), created_at: 29.day.ago)
    CreatedStat.create(count: rand(300), created_at: 31.day.ago)
    expect(CreatedStat.recent_stats_hash).to eq({one.created_at => one.count, two.created_at => two.count, three.created_at => three.count})
  end
end