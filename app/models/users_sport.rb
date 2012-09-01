class UsersSport < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :sport

  #Function that updates sports liked by users according to sports edited by user
  def self.add_user_sports(user_id, sport_ids)
    for sport_id in sport_ids
      user_act = UsersSport.find(:first,
        :conditions => ["user_id = ? and sport_id = ?",user_id, sport_id])
      if user_act.blank?
        UsersSport.create!(:user_id => user_id, :sport_id => sport_id)
      end
    end
    user_sport_ids = UsersSport.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:sport_id)
    
    for user_sport_id in user_sport_ids
      unless sport_ids.include?(user_sport_id)
        user_sport = UsersSport.find(:first,
          :conditions => ["user_id = ? and sport_id = ?",user_id,user_sport_id])
        user_sport.destroy
      end

    end
  end

  def self.get_common_sports_count(user_id_1, user_id_2)
    sports_user1 = UsersSport.find_all_by_user_id(user_id_1).collect(&:sport_id)
    sports_user2 = UsersSport.find_all_by_user_id(user_id_2).collect(&:sport_id)
    common_sports_ids = sports_user1 & sports_user2
    return common_sports_ids.size
  end
end
