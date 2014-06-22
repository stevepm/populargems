class AddFieldsToPopularGems < ActiveRecord::Migration
  def change
    add_column :popular_gems, :gh_stars, :integer
    add_column :popular_gems, :gh_forks, :integer
    add_column :popular_gems, :gh_issues, :integer
    add_column :popular_gems, :gh_updated_at, :datetime
  end
end
