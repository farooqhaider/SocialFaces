class User < ActiveRecord::Base

  belongs_to :current_location, :class_name => "Location", :foreign_key => "current_location_id"
  belongs_to :hometown, :class_name => "Location", :foreign_key => "hometown_id"
  has_many :users_languages
  has_many :languages, :through => :users_languages

  has_many :friends
  has_many :requests
  has_many :feeds
  
  has_many :users_musics
  has_many :musics, :through => :users_musics

  has_many :users_movies
  has_many :posts
  has_many :movies, :through => :users_movies

  has_many :albums_users
  has_many :albums, :through => :albums_users

  
  has_many :users_universities
  has_many :universities, :through => :users_universities
  has_many :users_schools
  has_many :schools, :through => :users_schools
  has_many :users_employers
  has_many :employers, :through => :users_employers

  has_many :users_albums
  has_many :albums, :through => :users_albums

  has_many :users_videos
  has_many :videos, :through => :users_videos

  has_many :users_lists
  has_many :lists, :through => :users_lists

  has_many :users_tv_shows
  has_many :tv_shows, :through => :users_tv_shows

  has_many :users_books
  has_many :books, :through => :users_books

  has_many :users_games
  has_many :games, :through => :users_games

  has_many :users_activities
  has_many :activities, :through => :users_activities

  has_many :users_interests
  has_many :interests, :through => :users_interests

  has_many :users_sports
  has_many :sports, :through => :users_sports

  has_many :users_teams
  has_many :teams, :through => :users_teams

  has_many :users_athletes
  has_many :athletes, :through => :users_athletes

  has_attached_file :photo,
                     :styles => {
                       :thumb => "160x120>",
                       :small => "250x250>"
                    }
	validates_attachment_size :photo, :less_than=> 4.megabytes
  validates_attachment_content_type :photo, :content_type=>['image/jpeg', 'image/png', 'image/gif']




  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :photo

  def self.find_by_ids(user_ids)
    users = User.find(:all, :conditions => ["id IN (?)",user_ids])
    return users
  end

  def self.get_paginated_mutual_friends(mutual_friend_ids, page)
    mutual_friends = User.paginate(:all,
      :conditions => ["id IN (?)",mutual_friend_ids],
      :order => "first_name",:page => page, :per_page => MUTUAL_FRIENDS_PER_PAGE)
    return mutual_friends
  end
  
  def self.get_friends_autocomplete(friend_ids,q)
    friend_users = User.find(:all,
      :conditions => ["(id IN (?)) AND (first_name like ? or last_name like ?)", friend_ids,"%#{q}%","%#{q}%"])
    return friend_users
  end

  def self.get_search_results(search_query,user_id)
    if search_query.include?(" ")
      names = search_query.split(" ")
      first_name = names[0]
      last_name = names[1]

      search_results = User.find(:all,
        :conditions => ["first_name = ? and last_name = ? and id != ?", first_name, last_name,user_id])

    else
      search_results = User.find(:all,
        :conditions => ["(first_name like ? or last_name like ? or email = ?) and id != ?", "%#{search_query}%", "%#{search_query}%",search_query,user_id])
    end
    return search_results
  end
  def self.get_search_suggestions_autocomplete(term, user_id)
    search_results = User.find(:all,
      :conditions => ["(first_name like ? or last_name like ? or email like ?) and id != ?", "%#{term}%", "%#{term}%",term,user_id])

    return search_results
  end
end
