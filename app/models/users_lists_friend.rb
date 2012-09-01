class UsersListsFriend < ActiveRecord::Base
  belongs_to :users_lists
  belongs_to :users

end
