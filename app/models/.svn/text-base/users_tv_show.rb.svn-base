class UsersTvShow < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :tv_show

  #Function that updates tv shows liked by users according to tv shows edited by user
  def self.add_user_tv_shows(user_id, tv_show_ids)
    for tv_show_id in tv_show_ids
      user_tv_show = UsersTvShow.find(:first,
        :conditions => ["user_id = ? and tv_show_id = ?",user_id, tv_show_id])
      if user_tv_show.blank?
        UsersTvShow.create!(:user_id => user_id, :tv_show_id => tv_show_id)
      end
    end
    user_tv_show_ids = UsersTvShow.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:tv_show_id)
    
    for user_tv_show_id in user_tv_show_ids
      unless tv_show_ids.include?(user_tv_show_id)
        user_tv_show = UsersTvShow.find(:first,
          :conditions => ["user_id = ? and tv_show_id = ?",user_id,user_tv_show_id])
        user_tv_show.destroy
      end

    end
  end
  def self.get_common_tv_shows_count(user_id_1, user_id_2)
    tv_shows_user1 = UsersTvShow.find_all_by_user_id(user_id_1).collect(&:tv_show_id)
    tv_shows_user2 = UsersTvShow.find_all_by_user_id(user_id_2).collect(&:tv_show_id)
    common_tv_shows_ids = tv_shows_user1 & tv_shows_user2
    return common_tv_shows_ids.size
  end
end
