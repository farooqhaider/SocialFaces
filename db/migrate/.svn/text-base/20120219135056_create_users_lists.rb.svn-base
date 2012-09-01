class CreateUsersLists < ActiveRecord::Migration
  def self.up
    create_table :users_lists do |t|
      t.integer :user_id
      t.integer :list_id
    end
    add_index :users_lists, [:user_id,:list_id]
  end

  def self.down
    drop_table :users_lists
  end
end
