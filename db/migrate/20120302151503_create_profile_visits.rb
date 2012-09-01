class CreateProfileVisits < ActiveRecord::Migration
  def self.up
    create_table :profile_visits do |t|
      t.integer :user_id
      t.integer :visitor_id
    end
    add_index :profile_visits, [:user_id,:visitor_id]
  end

  def self.down
    drop_table :profile_visits
  end
end
