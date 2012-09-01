class AddIndexesToTables1 < ActiveRecord::Migration
  def self.up

    add_index :activities, :name
    add_index :athletes, :name
    add_index :teams, :name
    add_index :sports, :name
    add_index :books, :name
    add_index :movies, :name
    add_index :musics, :name
    add_index :tv_shows, :name
    add_index :locations, :name
    add_index :languages, :name
    add_index :games, :name
    add_index :im_agents, :name
    add_index :interests, :name
    add_index :employers, :name
    add_index :universities, :name
    add_index :schools, :name

    add_index :users_activities, [:activity_id,:user_id]
    add_index :users_athletes, [:athlete_id,:user_id]
    add_index :users_teams, [:team_id,:user_id]
    add_index :users_books, [:book_id,:user_id]
    add_index :users_movies, [:movie_id,:user_id]
    add_index :users_musics, [:music_id,:user_id]
    add_index :users_tv_shows, [:tv_show_id,:user_id]
    add_index :users_games, [:game_id,:user_id]
    add_index :users_languages, [:language_id,:user_id]
    add_index :users_employers, [:employer_id,:user_id]
    add_index :users_interests, [:interest_id,:user_id]
    add_index :users_im_names, [:im_agent_id,:user_id]
    add_index :users_sports, [:sport_id,:user_id]
    add_index :users_emails, [:email_id,:user_id]
    add_index :users_universities, [:university_id,:user_id]
  end

  def self.down
    remove_index :activities, :name
    remove_index :athletes, :name
    remove_index :teams, :name
    remove_index :sports, :name
    remove_index :books, :name
    remove_index :movies, :name
    remove_index :musics, :name
    remove_index :tv_shows, :name
    remove_index :locations, :name
    remove_index :languages, :name
    remove_index :games, :name
    remove_index :im_agents, :name
    remove_index :interests, :name
    remove_index :employers, :name
    remove_index :universities, :name
    remove_index :schools, :name

    remove_index :users_activities, [:activitiy_id,:user_id]
    remove_index :users_athletes, [:athlete_id,:user_id]
    remove_index :users_teams, [:team_id,:user_id]
    remove_index :users_books, [:book_id,:user_id]
    remove_index :users_movies, [:movie_id,:user_id]
    remove_index :users_musics, [:music_id,:user_id]
    remove_index :users_tv_shows, [:tv_show_id,:user_id]
    remove_index :users_games, [:game_id,:user_id]
    remove_index :users_languages, [:language_id,:user_id]
    remove_index :users_employers, [:employer_id,:user_id]
    remove_index :users_interests, [:interest_id,:user_id]
    remove_index :users_im_names, [:im_agent_id,:user_id]
    remove_index :users_sports, [:sport_id,:user_id]
    remove_index :users_emails, [:email_id,:user_id]
    remove_index :users_universities, [:university_id,:user_id]
  end
end
