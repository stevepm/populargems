class AddScorePercentageToPopularGems < ActiveRecord::Migration
  def change
    add_column :popular_gems, :score_percentage, :float
  end
end
