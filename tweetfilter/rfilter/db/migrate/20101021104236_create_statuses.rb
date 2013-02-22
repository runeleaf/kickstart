class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :status_id
      t.string :name
      t.string :screen_name
      t.string :url
      t.string :source
      t.string :via
      t.text :entry
      t.datetime :published_at

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
