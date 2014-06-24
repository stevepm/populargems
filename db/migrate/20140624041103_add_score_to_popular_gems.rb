class AddScoreToPopularGems < ActiveRecord::Migration
  def change
    add_column :popular_gems, :score, :float
  end
end
