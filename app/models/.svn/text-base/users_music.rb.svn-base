class UsersMusic < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :music

  #Function that updates music liked by users according to music edited by user
  def self.add_user_musics(user_id, music_ids)
    for music_id in music_ids
      user_music = UsersMusic.find(:first,
        :conditions => ["user_id = ? and music_id = ?",user_id, music_id])
      if user_music.blank?
        UsersMusic.create!(:user_id => user_id, :music_id => music_id)
      end
    end
    user_music_ids = UsersMusic.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:music_id)
    
    for user_music_id in user_music_ids
      unless music_ids.include?(user_music_id)
        user_music = UsersMusic.find(:first,
          :conditions => ["user_id = ? and music_id = ?",user_id,user_music_id])
        user_music.destroy
      end

    end
  end

  def self.get_common_musics_count(user_id_1, user_id_2)
    musics_user1 = UsersMusic.find_all_by_user_id(user_id_1).collect(&:music_id)
    musics_user2 = UsersMusic.find_all_by_user_id(user_id_2).collect(&:music_id)
    common_musics_ids = musics_user1 & musics_user2
    return common_musics_ids.size
  end
  
end
