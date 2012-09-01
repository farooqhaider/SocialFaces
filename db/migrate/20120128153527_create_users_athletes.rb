class CreateUsersAthletes < ActiveRecord::Migration
  def self.up
    create_table :users_athletes do |t|
      t.integer :user_id
      t.integer :athlete_id
    end
  end

  def self.down
    drop_table :users_athletes
  end
end
