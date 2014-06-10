class AddFeaturedToPopularGems < ActiveRecord::Migration
  def change
    add_column :popular_gems, :featured, :boolean, default: false
  end
end
