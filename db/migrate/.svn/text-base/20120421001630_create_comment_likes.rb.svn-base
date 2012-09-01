class CreateCommentLikes < ActiveRecord::Migration
  def self.up
    create_table :comment_likes do |t|

      t.integer :comment_id
      t.integer :like_user_id

      t.timestamps
    end
    add_column :comments, :created_at, :datetime
  end

  def self.down
    drop_table :comment_likes
    remove_column :comments, :created_at
  end
end
