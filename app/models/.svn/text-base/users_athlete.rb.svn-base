class UsersAthlete < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :athlete

  #Function that updates athletes liked by users according to athletes edited by user
  def self.add_user_athletes(user_id, athlete_ids)
    for athlete_id in athlete_ids
      user_act = UsersAthlete.find(:first,
        :conditions => ["user_id = ? and athlete_id = ?",user_id, athlete_id])
      if user_act.blank?
        UsersAthlete.create!(:user_id => user_id, :athlete_id => athlete_id)
      end
    end
    user_athlete_ids = UsersAthlete.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:athlete_id)
    
    for user_athlete_id in user_athlete_ids
      unless athlete_ids.include?(user_athlete_id)
        user_athlete = UsersAthlete.find(:first,
          :conditions => ["user_id = ? and athlete_id = ?",user_id,user_athlete_id])
        user_athlete.destroy
      end

    end
  end

  def self.get_common_athletes_count(user_id_1, user_id_2)
    athletes_user1 = UsersAthlete.find_all_by_user_id(user_id_1).collect(&:athlete_id)
    athletes_user2 = UsersAthlete.find_all_by_user_id(user_id_2).collect(&:athlete_id)
    common_athletes_ids = athletes_user1 & athletes_user2
    return common_athletes_ids.size
  end
  
end
