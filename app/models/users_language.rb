class UsersLanguage < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :language

  #Function that updates user's languages according to languages edited by user
  def self.add_user_languages(user_id, language_ids)
    for language_id in language_ids
      user_lan = UsersLanguage.find(:first,
        :conditions => ["user_id = ? and language_id = ?",user_id, language_id])
      if user_lan.blank?
        UsersLanguage.create!(:user_id => user_id, :language_id => language_id)
      end
    end
    user_language_ids = UsersLanguage.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:language_id)
    
    for user_language_id in user_language_ids
      unless language_ids.include?(user_language_id)
        user_language = UsersLanguage.find(:first,
          :conditions => ["user_id = ? and language_id = ?",user_id,user_language_id])
        user_language.destroy
      end

    end
  end

  def self.get_common_languages_count(user_id_1, user_id_2)
    languages_user1 = UsersLanguage.find_all_by_user_id(user_id_1).collect(&:language_id)
    languages_user2 = UsersLanguage.find_all_by_user_id(user_id_2).collect(&:language_id)
    common_languages_ids = languages_user1 & languages_user2
    return common_languages_ids.size
  end
end
