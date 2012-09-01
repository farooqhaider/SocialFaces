class CreateUsersSports < ActiveRecord::Migration
  def self.up
    create_table :users_sports do |t|
      t.integer :sport_id
      t.integer :user_id
      t.text :description
    end
  end

  def self.down
    drop_table :users_sports
  end
end
