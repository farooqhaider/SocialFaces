class Interest < ActiveRecord::Base
  has_many :users_interests
  has_many :users, :through => :users_interests
end
