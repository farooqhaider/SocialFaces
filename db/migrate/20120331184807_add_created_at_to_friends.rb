class AddCreatedAtToFriends < ActiveRecord::Migration
  def self.up
    add_column :friends, :created_at, :datetime
  end

  def self.down
    remove_column :friends, :created_at, :datetime
  end
end
