class UsersEmployer < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :employer

  #Function that updates user's employers according to employers edited by user
  def self.add_user_employers(user_id, employer_ids)
    for employer_id in employer_ids
      user_emp = UsersEmployer.find(:first,
        :conditions => ["user_id = ? and employer_id = ?",user_id, employer_id])
      if user_emp.blank?
        UsersEmployer.create!(:user_id => user_id, :employer_id => employer_id)
      end
    end
    user_employer_ids = UsersEmployer.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:employer_id)
    
    for user_employer_id in user_employer_ids
      unless employer_ids.include?(user_employer_id)
        user_employer = UsersEmployer.find(:first,
          :conditions => ["user_id = ? and employer_id = ?",user_id,user_employer_id])
        user_employer.destroy
      end

    end
  end

  def self.get_common_employers_count(user_id_1, user_id_2)
    employers_user1 = UsersEmployer.find_all_by_user_id(user_id_1).collect(&:employer_id)
    employers_user2 = UsersEmployer.find_all_by_user_id(user_id_2).collect(&:employer_id)
    common_employers_ids = employers_user1 & employers_user2
    return common_employers_ids.size
  end
end
