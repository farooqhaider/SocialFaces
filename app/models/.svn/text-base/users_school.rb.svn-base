class UsersSchool < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :school

  #Function that updates user's schools according to schools edited by user
  def self.add_user_schools(user_id, school_ids)
    for school_id in school_ids
      user_sch = UsersSchool.find(:first,
        :conditions => ["user_id = ? and school_id = ?",user_id, school_id])
      if user_sch.blank?
        UsersSchool.create!(:user_id => user_id, :school_id => school_id)
      end
    end
    user_school_ids = UsersSchool.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:school_id)
    
    for user_school_id in user_school_ids
      unless school_ids.include?(user_school_id)
        user_school = UsersSchool.find(:first,
          :conditions => ["user_id = ? and school_id = ?",user_id,user_school_id])
        user_school.destroy
      end

    end
  end

  def self.get_common_schools_count(user_id_1, user_id_2)
    schools_user1 = UsersSchool.find_all_by_user_id(user_id_1).collect(&:school_id)
    schools_user2 = UsersSchool.find_all_by_user_id(user_id_2).collect(&:school_id)
    common_schools_ids = schools_user1 & schools_user2
    return common_schools_ids.size
  end
  
end
