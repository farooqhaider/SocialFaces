class AddTimestampsToPhotosUsers < ActiveRecord::Migration
  def self.up
    add_column :photos_users, :created_at, :datetime
  end

  def self.down
    remove_column :photos_users, :created_at, :datetime
  end
end
