class TvShow < ActiveRecord::Base
  has_many :users_tv_shows
  has_many :users, :through => :users_tv_shows
end
