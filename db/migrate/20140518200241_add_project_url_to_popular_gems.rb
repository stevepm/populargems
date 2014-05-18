class AddProjectUrlToPopularGems < ActiveRecord::Migration
  def change
    add_column :popular_gems, :project_url, :string
  end
end
