class Athlete < ActiveRecord::Base
  has_many :users_athletes
  has_many :users, :through => :users_athletes
end
