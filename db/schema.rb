# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120421001630) do

  create_table "activities", :force => true do |t|
    t.string "name"
  end

  add_index "activities", ["name"], :name => "index_activities_on_name"

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "location_id"
    t.datetime "date_album"
    t.string   "quality"
    t.boolean  "followed"
    t.boolean  "posted"
    t.integer  "cover_photo"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["owner_id"], :name => "index_albums_on_owner_id"
  add_index "albums", ["title"], :name => "index_albums_on_title"

  create_table "albums_photos", :force => true do |t|
    t.integer "album_id"
    t.integer "photo_id"
  end

  add_index "albums_photos", ["album_id", "photo_id"], :name => "index_albums_photos_on_album_id_and_photo_id"

  create_table "albums_tagged_users", :force => true do |t|
    t.integer "album_id"
    t.integer "user_id"
  end

  add_index "albums_tagged_users", ["album_id", "user_id"], :name => "index_albums_tagged_users_on_album_id_and_user_id"

  create_table "athletes", :force => true do |t|
    t.string "name"
  end

  add_index "athletes", ["name"], :name => "index_athletes_on_name"

  create_table "books", :force => true do |t|
    t.string "name"
  end

  add_index "books", ["name"], :name => "index_books_on_name"

  create_table "comment_likes", :force => true do |t|
    t.integer  "comment_id"
    t.integer  "like_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentee_user_id"
    t.string   "description"
    t.integer  "post_id"
    t.datetime "created_at"
  end

  create_table "employers", :force => true do |t|
    t.string "name"
  end

  add_index "employers", ["name"], :name => "index_employers_on_name"

  create_table "feeds", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "feed_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friend_suggestions", :force => true do |t|
    t.integer "suggestor_user_id"
    t.integer "suggested_user_id"
    t.integer "suggestee_user_id"
  end

  add_index "friend_suggestions", ["suggestee_user_id"], :name => "index_friend_suggestions_on_suggestee_user_id"

  create_table "friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
  end

  add_index "friends", ["user_id", "friend_id"], :name => "index_friends_on_user_id_and_friend_id"

  create_table "games", :force => true do |t|
    t.string "name"
  end

  add_index "games", ["name"], :name => "index_games_on_name"

  create_table "im_agents", :force => true do |t|
    t.string "name"
  end

  add_index "im_agents", ["name"], :name => "index_im_agents_on_name"

  create_table "inspiring_people", :force => true do |t|
    t.string "name"
  end

  create_table "interests", :force => true do |t|
    t.string "name"
  end

  add_index "interests", ["name"], :name => "index_interests_on_name"

  create_table "languages", :force => true do |t|
    t.string "name"
  end

  add_index "languages", ["name"], :name => "index_languages_on_name"

  create_table "likes", :force => true do |t|
    t.integer "like_user_id"
    t.integer "post_id"
  end

  create_table "lists", :force => true do |t|
    t.string "name"
  end

  add_index "lists", ["name"], :name => "index_lists_on_name"

  create_table "locations", :force => true do |t|
    t.string "name"
  end

  add_index "locations", ["name"], :name => "index_locations_on_name"

  create_table "movies", :force => true do |t|
    t.string "name"
  end

  add_index "movies", ["name"], :name => "index_movies_on_name"

  create_table "musics", :force => true do |t|
    t.string "name"
  end

  add_index "musics", ["name"], :name => "index_musics_on_name"

  create_table "notifications", :force => true do |t|
    t.text     "description"
    t.integer  "user_id"
    t.integer  "checked",     :default => 0
    t.string   "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.string   "caption"
    t.string   "description"
    t.integer  "location_id"
    t.datetime "date_taken"
    t.string   "quality"
    t.boolean  "followed"
    t.boolean  "posted"
    t.string   "current_state"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["owner_id"], :name => "index_photos_on_owner_id"

  create_table "photos_users", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "photos_users", ["photo_id", "user_id"], :name => "index_photos_users_on_photo_id_and_user_id"

  create_table "political_views", :force => true do |t|
    t.string "name"
  end

  create_table "posts", :force => true do |t|
    t.string   "content_type"
    t.integer  "content_id"
    t.string   "caption"
    t.text     "description"
    t.text     "text"
    t.integer  "location_id"
    t.date     "date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id_for"
  end

  create_table "posts_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profile_visits", :force => true do |t|
    t.integer "user_id"
    t.integer "visitor_id"
    t.integer "count"
  end

  add_index "profile_visits", ["user_id", "visitor_id"], :name => "index_profile_visits_on_user_id_and_visitor_id"

  create_table "religions", :force => true do |t|
    t.string "name"
  end

  create_table "report_abuses", :force => true do |t|
    t.integer "reported_item_id"
    t.string  "item_type"
    t.integer "reported_by_user_id"
    t.string  "description"
  end

  create_table "requests", :force => true do |t|
    t.integer "user_id"
    t.integer "req_id"
  end

  add_index "requests", ["user_id", "req_id"], :name => "index_requests_on_user_id_and_req_id"

  create_table "schools", :force => true do |t|
    t.string "name"
  end

  add_index "schools", ["name"], :name => "index_schools_on_name"

  create_table "shares", :force => true do |t|
    t.string   "caption"
    t.text     "description"
    t.text     "text"
    t.integer  "location_id"
    t.integer  "post_id"
    t.date     "date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shared_by_id"
    t.integer  "shared_with_id"
  end

  create_table "shares_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "share_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sports", :force => true do |t|
    t.string "name"
  end

  add_index "sports", ["name"], :name => "index_sports_on_name"

  create_table "teams", :force => true do |t|
    t.string "name"
  end

  add_index "teams", ["name"], :name => "index_teams_on_name"

  create_table "tv_shows", :force => true do |t|
    t.string "name"
  end

  add_index "tv_shows", ["name"], :name => "index_tv_shows_on_name"

  create_table "unfollowed_posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "universities", :force => true do |t|
    t.string "name"
  end

  add_index "universities", ["name"], :name => "index_universities_on_name"

  create_table "unsubscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "unsubscribed_user_id"
    t.string   "feed_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_accounts", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.integer  "user_profiles_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",    :limit => 128, :default => "", :null => false
    t.string   "password_salt",                        :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "gender"
    t.string   "adress_zipcode"
    t.string   "address_neighbourhood"
    t.text     "address"
    t.integer  "address_towncity"
    t.string   "interested_in"
    t.string   "alternate_name"
    t.integer  "religion_id"
    t.text     "religion_desc"
    t.integer  "political_view_id"
    t.text     "political_views_desc"
    t.text     "favorite_quotes"
    t.text     "about_me"
    t.string   "relationship_status"
    t.integer  "current_location_id"
    t.integer  "hometown_id"
    t.text     "website"
    t.string   "display_as"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "show_gender"
    t.string   "show_bd"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_activities", :force => true do |t|
    t.integer "activity_id"
    t.integer "user_id"
    t.text    "description"
  end

  add_index "users_activities", ["activity_id", "user_id"], :name => "index_users_activities_on_activity_id_and_user_id"

  create_table "users_albums", :force => true do |t|
    t.integer "user_id"
    t.integer "album_id"
  end

  add_index "users_albums", ["user_id", "album_id"], :name => "index_users_albums_on_user_id_and_album_id"

  create_table "users_athletes", :force => true do |t|
    t.integer "user_id"
    t.integer "athlete_id"
  end

  add_index "users_athletes", ["athlete_id", "user_id"], :name => "index_users_athletes_on_athlete_id_and_user_id"

  create_table "users_books", :force => true do |t|
    t.integer "user_id"
    t.integer "book_id"
  end

  add_index "users_books", ["book_id", "user_id"], :name => "index_users_books_on_book_id_and_user_id"

  create_table "users_emails", :force => true do |t|
    t.integer "user_id"
    t.string  "email_id"
  end

  add_index "users_emails", ["email_id", "user_id"], :name => "index_users_emails_on_email_id_and_user_id"

  create_table "users_emp_projects", :force => true do |t|
    t.integer "user_employer_id"
    t.string  "name"
    t.text    "description"
    t.integer "from_day"
    t.string  "from_month"
    t.integer "from_year"
    t.integer "to_day"
    t.string  "to_month"
    t.integer "to_year"
    t.boolean "currently_working"
  end

  create_table "users_employers", :force => true do |t|
    t.integer "user_id"
    t.integer "employer_id"
    t.string  "position"
    t.integer "location_id"
    t.text    "description"
    t.integer "from_day"
    t.string  "from_month"
    t.integer "from_year"
    t.integer "to_day"
    t.string  "to_month"
    t.integer "to_year"
    t.boolean "currently_working"
  end

  add_index "users_employers", ["employer_id", "user_id"], :name => "index_users_employers_on_employer_id_and_user_id"

  create_table "users_games", :force => true do |t|
    t.integer "user_id"
    t.integer "game_id"
  end

  add_index "users_games", ["game_id", "user_id"], :name => "index_users_games_on_game_id_and_user_id"

  create_table "users_im_names", :force => true do |t|
    t.integer "user_id"
    t.string  "im_agent_id"
    t.string  "im_name"
  end

  add_index "users_im_names", ["im_agent_id", "user_id"], :name => "index_users_im_names_on_im_agent_id_and_user_id"

  create_table "users_inspiring_people", :force => true do |t|
    t.integer "user_id"
    t.integer "inspiring_person_id"
  end

  create_table "users_interests", :force => true do |t|
    t.integer "interest_id"
    t.integer "user_id"
    t.text    "description"
  end

  add_index "users_interests", ["interest_id", "user_id"], :name => "index_users_interests_on_interest_id_and_user_id"

  create_table "users_languages", :force => true do |t|
    t.integer "user_id"
    t.integer "language_id"
  end

  add_index "users_languages", ["language_id", "user_id"], :name => "index_users_languages_on_language_id_and_user_id"

  create_table "users_lists", :force => true do |t|
    t.integer "user_id"
    t.integer "list_id"
  end

  add_index "users_lists", ["user_id", "list_id"], :name => "index_users_lists_on_user_id_and_list_id"

  create_table "users_lists_friends", :force => true do |t|
    t.integer "user_list_id"
    t.integer "friend_id"
  end

  add_index "users_lists_friends", ["friend_id", "user_list_id"], :name => "index_users_lists_friends_on_friend_id_and_user_list_id"

  create_table "users_movies", :force => true do |t|
    t.integer "user_id"
    t.integer "movie_id"
  end

  add_index "users_movies", ["movie_id", "user_id"], :name => "index_users_movies_on_movie_id_and_user_id"

  create_table "users_musics", :force => true do |t|
    t.integer "user_id"
    t.integer "music_id"
  end

  add_index "users_musics", ["music_id", "user_id"], :name => "index_users_musics_on_music_id_and_user_id"

  create_table "users_schools", :force => true do |t|
    t.integer "user_id"
    t.integer "school_id"
  end

  add_index "users_schools", ["user_id", "school_id"], :name => "index_users_schools_on_user_id_and_school_id"

  create_table "users_sports", :force => true do |t|
    t.integer "sport_id"
    t.integer "user_id"
    t.text    "description"
  end

  add_index "users_sports", ["sport_id", "user_id"], :name => "index_users_sports_on_sport_id_and_user_id"

  create_table "users_teams", :force => true do |t|
    t.integer "user_id"
    t.integer "team_id"
  end

  add_index "users_teams", ["team_id", "user_id"], :name => "index_users_teams_on_team_id_and_user_id"

  create_table "users_tv_shows", :force => true do |t|
    t.integer "user_id"
    t.integer "tv_show_id"
  end

  add_index "users_tv_shows", ["tv_show_id", "user_id"], :name => "index_users_tv_shows_on_tv_show_id_and_user_id"

  create_table "users_universities", :force => true do |t|
    t.integer "user_id"
    t.integer "university_id"
    t.string  "position"
    t.integer "location_id"
    t.text    "description"
    t.integer "from_day"
    t.string  "from_month"
    t.integer "from_year"
    t.integer "to_day"
    t.string  "to_month"
    t.integer "to_year"
    t.boolean "graduated"
    t.string  "course_1"
    t.string  "coures_2"
    t.string  "course_3"
    t.boolean "attended_for"
    t.string  "postgrad_degree"
  end

  add_index "users_universities", ["university_id", "user_id"], :name => "index_users_universities_on_university_id_and_user_id"

  create_table "videos", :force => true do |t|
    t.string   "source_content_type"
    t.string   "source_file_name"
    t.integer  "source_file_size"
    t.string   "state"
    t.string   "title"
    t.text     "description"
    t.text     "caption"
    t.string   "location"
    t.date     "date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["user_id"], :name => "index_videos_on_user_id"

  create_table "videos_users", :force => true do |t|
    t.integer "user_id"
    t.integer "video_id"
  end

  add_index "videos_users", ["user_id", "video_id"], :name => "index_videos_users_on_user_id_and_video_id"

  create_table "wall_activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "content_type"
    t.integer  "content_id"
    t.string   "activity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "with_activities", :force => true do |t|
    t.integer "user_activity_id"
    t.integer "with_user_id"
  end

  create_table "with_projects", :force => true do |t|
    t.integer "user_emp_project_id"
    t.integer "with_user_id"
  end

  create_table "with_sports", :force => true do |t|
    t.integer "user_sport_id"
    t.integer "with_user_id"
  end

end
