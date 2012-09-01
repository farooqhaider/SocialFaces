class CreateUsersInterests < ActiveRecord::Migration
  def self.up
    create_table :users_interests do |t|
      t.integer :interest_id
      t.integer :user_id
      t.text :description
    end
  end

  def self.down
    drop_table :users_interests
  end
end
