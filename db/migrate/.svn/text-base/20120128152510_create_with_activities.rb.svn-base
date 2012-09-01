class CreateWithActivities < ActiveRecord::Migration
  def self.up
    create_table :with_activities do |t|
      t.integer :user_activity_id
      t.integer :with_user_id
    end
  end

  def self.down
    drop_table :with_activities
  end
end
