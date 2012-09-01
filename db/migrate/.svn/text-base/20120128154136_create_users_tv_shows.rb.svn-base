class CreateUsersTvShows < ActiveRecord::Migration
  def self.up
    create_table :users_tv_shows do |t|
      t.integer :user_id
      t.integer :tv_shows_id
    end
  end

  def self.down
    drop_table :users_tv_shows
  end
end
