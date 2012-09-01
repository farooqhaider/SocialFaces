class UsersActivity < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :activity

  #Function that updates user activities according to activities edited by user
  def self.add_user_activities(user_id, activity_ids)
    for activity_id in activity_ids
      user_act = UsersActivity.find(:first,
        :conditions => ["user_id = ? and activity_id = ?",user_id, activity_id])
      if user_act.blank?
        UsersActivity.create!(:user_id => user_id, :activity_id => activity_id)
      end
    end
    user_activity_ids = UsersActivity.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:activity_id)
    
    for user_activity_id in user_activity_ids
      unless activity_ids.include?(user_activity_id)
        user_activity = UsersActivity.find(:first,
          :conditions => ["user_id = ? and activity_id = ?",user_id,user_activity_id])
        user_activity.destroy
      end

    end
  end

  def self.get_common_activities_count(user_id_1, user_id_2)
    activities_user1 = UsersActivity.find_all_by_user_id(user_id_1).collect(&:activity_id)
    activities_user2 = UsersActivity.find_all_by_user_id(user_id_2).collect(&:activity_id)
    common_activities_ids = activities_user1 & activities_user2
    return common_activities_ids.size
  end
end
