class CreateUsersAlbums < ActiveRecord::Migration
  def self.up
    create_table :users_albums do |t|
      t.integer :user_id
      t.integer :album_id
    end
    add_index :users_albums, [:user_id,:album_id]
  end

  def self.down
    drop_table :users_albums
  end
end
