class UsersTeam < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :team

  #Function that updates teams liked by users according to teams edited by user
  def self.add_user_teams(user_id, team_ids)
    for team_id in team_ids
      user_act = UsersTeam.find(:first,
        :conditions => ["user_id = ? and team_id = ?",user_id, team_id])
      if user_act.blank?
        UsersTeam.create!(:user_id => user_id, :team_id => team_id)
      end
    end
    user_team_ids = UsersTeam.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:team_id)
    
    for user_team_id in user_team_ids
      unless team_ids.include?(user_team_id)
        user_team = UsersTeam.find(:first,
          :conditions => ["user_id = ? and team_id = ?",user_id,user_team_id])
        user_team.destroy
      end

    end
  end

  def self.get_common_teams_count(user_id_1, user_id_2)
    teams_user1 = UsersTeam.find_all_by_user_id(user_id_1).collect(&:team_id)
    teams_user2 = UsersTeam.find_all_by_user_id(user_id_2).collect(&:team_id)
    common_teams_ids = teams_user1 & teams_user2
    return common_teams_ids.size
  end
end
