class CreateHearts < ActiveRecord::Migration
  def change
    create_table :hearts do |t|
      t.references :user, index: true
      t.references :popular_gem, index: true

      t.timestamps
    end
  end
end
