class AddIndexesToTables2 < ActiveRecord::Migration
  def self.up
    add_index :albums, :owner_id
    add_index :albums, :title
    add_index :albums_photos, [:album_id,:photo_id]
    add_index :albums_tagged_users, [:album_id,:user_id]
    add_index :friend_suggestions, :suggestee_user_id
    add_index :photos, :owner_id
    add_index :photos_users, [:photo_id,:user_id]
    add_index :videos, :user_id
    add_index :videos_users, [:user_id,:video_id]
  end

  def self.down
    remove_index :albums, :owner_id
    remove_index :albums, :title
    remove_index :albums_photos, [:album_id,:photo_id]
    remove_index :albums_tagged_users, [:album_id,:user_id]
    remove_index :friend_suggestions, :suggestee_user_id
    remove_index :photos, :owner_id
    remove_index :photos_users, [:photo_id,:user_id]
    remove_index :videos, :user_id
    remove_index :videos_users, [:user_id,:video_id]
  end
end
