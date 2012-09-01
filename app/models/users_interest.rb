class UsersInterest < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :interest

  #Function that updates user's interests according to interests edited by user
  def self.add_user_interests(user_id, interest_ids)
    for interest_id in interest_ids
      user_int = UsersInterest.find(:first,
        :conditions => ["user_id = ? and interest_id = ?",user_id, interest_id])
      if user_int.blank?
        UsersInterest.create!(:user_id => user_id, :interest_id => interest_id)
      end
    end
    user_interest_ids = UsersInterest.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:interest_id)
    
    for user_interest_id in user_interest_ids
      unless interest_ids.include?(user_interest_id)
        user_interest = UsersInterest.find(:first,
          :conditions => ["user_id = ? and interest_id = ?",user_id,user_interest_id])
        user_interest.destroy
      end

    end
  end

  def self.get_common_interests_count(user_id_1, user_id_2)
    interests_user1 = UsersInterest.find_all_by_user_id(user_id_1).collect(&:interest_id)
    interests_user2 = UsersInterest.find_all_by_user_id(user_id_2).collect(&:interest_id)
    common_interests_ids = interests_user1 & interests_user2
    return common_interests_ids.size
  end
end
