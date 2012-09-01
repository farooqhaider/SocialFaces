class UsersList < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :list

  def self.get_common_lists_count(user_id, suggestee_id, friend_id)
    lists = User.find_by_id(user_id).lists
    count = 0
    for list in lists
      users_list = UsersList.find_by_user_id_and_list_id(user_id,list.id)
      user_list_friends = UsersListsFriend.find(:all, :conditions => ["user_list_id = ?",users_list.id]).collect(&:friend_id)
      if user_list_friends.include?(suggestee_id) and user_list_friends.include?(friend_id)
        count += 1
      end
    end
    return count
  end
  def self.create_default_lists(user_id)
    UsersList.create(:user_id => user_id, :list_id => 1)
    UsersList.create(:user_id => user_id, :list_id => 2)
    UsersList.create(:user_id => user_id, :list_id => 3)
    UsersList.create(:user_id => user_id, :list_id => 4)
    UsersList.create(:user_id => user_id, :list_id => 5)
  end
end
