class UsersGame < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :game

  #Function that updates games liked by users according to games edited by user
  def self.add_user_games(user_id, game_ids)
    for game_id in game_ids
      user_game = UsersGame.find(:first,
        :conditions => ["user_id = ? and game_id = ?",user_id, game_id])
      if user_game.blank?
        UsersGame.create!(:user_id => user_id, :game_id => game_id)
      end
    end
    user_game_ids = UsersGame.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:game_id)
    
    for user_game_id in user_game_ids
      unless game_ids.include?(user_game_id)
        user_game = UsersGame.find(:first,
          :conditions => ["user_id = ? and game_id = ?",user_id,user_game_id])
        user_game.destroy
      end

    end
  end

  def self.get_common_games_count(user_id_1, user_id_2)
    games_user1 = UsersGame.find_all_by_user_id(user_id_1).collect(&:game_id)
    games_user2 = UsersGame.find_all_by_user_id(user_id_2).collect(&:game_id)
    common_games_ids = games_user1 & games_user2
    return common_games_ids.size
  end
end
