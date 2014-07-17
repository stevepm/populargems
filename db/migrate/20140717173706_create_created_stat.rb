class CreateCreatedStat < ActiveRecord::Migration
  def change
    create_table :created_stats do |t|
      t.integer :count
      t.timestamps
    end
  end
end
