class UpdatedStat < ActiveRecord::Base
  def self.recent_stats_hash(days = 30)
    stats = {}
    where("created_at >= ?", days.day.ago).each do |stat|
      stats[stat.created_at] = stat.count
    end
    stats
  end
end