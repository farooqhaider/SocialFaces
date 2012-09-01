class RenameAlbumsUsers < ActiveRecord::Migration
  def self.up
    rename_table :albums_users , :albums_tagged_users
  end

  def self.down
    rename_table :albums_tagged_users, :albums_users
  end
end
