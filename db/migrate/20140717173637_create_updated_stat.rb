class CreateUpdatedStat < ActiveRecord::Migration
  def change
    create_table :updated_stats do |t|
      t.integer :count
      t.timestamps
    end
  end
end
