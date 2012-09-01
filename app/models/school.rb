class School < ActiveRecord::Base
  has_many :users_schools
  has_many :users, :through => :users_schools
end
