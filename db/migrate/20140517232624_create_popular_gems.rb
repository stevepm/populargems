class CreatePopularGems < ActiveRecord::Migration
  def change
    create_table :popular_gems do |t|
      t.string :name
      t.string :version
      t.integer :total_downloads
      t.integer :version_downloads
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end
