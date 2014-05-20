class ChangeDescriptionTypeInPopularGems < ActiveRecord::Migration
  def change
    change_column :popular_gems, :description, :text
  end
end
