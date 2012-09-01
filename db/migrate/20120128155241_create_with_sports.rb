class CreateWithSports < ActiveRecord::Migration
  def self.up
    create_table :with_sports do |t|
      t.integer :user_sport_id
      t.integer :with_user_id
    end
  end

  def self.down
    drop_table :with_sports
  end
end
