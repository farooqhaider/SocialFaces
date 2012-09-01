class Post < ActiveRecord::Base
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :location, :class_name => "Location", :foreign_key => "location_id"

  has_many :feeds
  has_many :users, :through => :posts_users
end
