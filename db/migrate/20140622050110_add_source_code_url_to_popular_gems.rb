class AddSourceCodeUrlToPopularGems < ActiveRecord::Migration
  def change
    add_column :popular_gems, :source_code_url, :string
  end
end
