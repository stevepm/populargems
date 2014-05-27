class AddSlugsToPopularGems < ActiveRecord::Migration
  def change
    add_column :popular_gems, :slug, :string
    add_index :popular_gems, :slug, unique: true
  end
end
