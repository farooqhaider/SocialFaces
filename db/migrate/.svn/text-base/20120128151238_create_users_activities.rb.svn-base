class CreateUsersActivities < ActiveRecord::Migration
  def self.up
    create_table :users_activities do |t|
      t.integer :activity_id
      t.integer :user_id
      t.text :description
    end
  end

  def self.down
    drop_table :users_activities
  end
end
