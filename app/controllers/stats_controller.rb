class StatsController < ApplicationController
  def index
    @created_stats = CreatedStat.recent_stats_hash
    @updated_stats = UpdatedStat.recent_stats_hash
  end
end