class CreateUsersListsFriends < ActiveRecord::Migration
  def self.up
    create_table :users_lists_friends do |t|
      t.integer :user_list_id
      t.integer :friend_id
    end
    add_index :users_lists_friends, [:friend_id, :user_list_id]
  end

  def self.down
    drop_table :users_lists_friends
  end
end
