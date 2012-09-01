class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :content_type
      t.integer :content_id

      t.string :caption
      t.text :description
      t.text :text
      
      t.integer :location_id
      t.date :date

      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
