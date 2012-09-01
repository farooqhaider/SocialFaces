class CreateUsersMovies < ActiveRecord::Migration
  def self.up
    create_table :users_movies do |t|
      t.integer :user_id
      t.integer :movie_id
    end
  end

  def self.down
    drop_table :users_movies
  end
end
