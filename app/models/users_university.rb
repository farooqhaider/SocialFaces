class UsersUniversity < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :university

  #Function that updates universities according to universities edited by user
  def self.add_user_universities(user_id, university_ids)
    for university_id in university_ids
      user_univ = UsersUniversity.find(:first,
        :conditions => ["user_id = ? and university_id = ?",user_id, university_id])
      if user_univ.blank?
        UsersUniversity.create!(:user_id => user_id, :university_id => university_id)
      end
    end
    user_university_ids = UsersUniversity.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:university_id)
    
    for user_university_id in user_university_ids
      unless university_ids.include?(user_university_id)
        user_university = UsersUniversity.find(:first,
          :conditions => ["user_id = ? and university_id = ?",user_id,user_university_id])
        user_university.destroy
      end

    end
  end

  def self.get_common_universities_count(user_id_1, user_id_2)
    universities_user1 = UsersUniversity.find_all_by_user_id(user_id_1).collect(&:university_id)
    universities_user2 = UsersUniversity.find_all_by_user_id(user_id_2).collect(&:university_id)
    common_universities_ids = universities_user1 & universities_user2
    return common_universities_ids.size
  end
end
