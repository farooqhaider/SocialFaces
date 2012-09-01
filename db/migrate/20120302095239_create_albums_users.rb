class CreateAlbumsUsers < ActiveRecord::Migration
  def self.up
    create_table :albums_users do |t|
      t.integer :album_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :albums_users
  end
end
