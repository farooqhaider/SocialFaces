class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|

      t.string :source_content_type
      t.string :source_file_name
      t.integer :source_file_size
      t.string :state

      t.string :title
      t.text :description
      t.text :caption
      t.string :location
      t.date :date

      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
