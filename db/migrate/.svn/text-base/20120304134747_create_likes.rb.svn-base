class CreateLikes < ActiveRecord::Migration
  def self.up
    create_table :likes do |t|
      t.integer :item_id
      t.integer :user_id
      t.integer :like_user_id
      t.string :item_type
    end
  end

  def self.down
    drop_table :likes
  end
end
