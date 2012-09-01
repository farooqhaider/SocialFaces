class CreatePhotosUsers < ActiveRecord::Migration
  #table to save the users tagged in photos
  def self.up
    create_table :photos_users do |t|
      t.integer :photo_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :photos_users
  end
end
