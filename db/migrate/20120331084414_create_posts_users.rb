class CreatePostsUsers < ActiveRecord::Migration
  def self.up
    create_table :posts_users do |t|
      t.integer :user_id
      t.integer :post_id
      t.timestamps
    end
  end

  def self.down
    drop_table :posts_users
  end
end
