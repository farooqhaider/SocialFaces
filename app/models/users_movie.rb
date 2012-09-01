class UsersMovie < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :movie
#Function that updates movies liked by users according to movies edited by user
  def self.add_user_movies(user_id, movie_ids)
    for movie_id in movie_ids
      user_movie = UsersMovie.find(:first,
        :conditions => ["user_id = ? and movie_id = ?",user_id, movie_id])
      if user_movie.blank?
        UsersMovie.create!(:user_id => user_id, :movie_id => movie_id)
      end
    end
    user_movie_ids = UsersMovie.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:movie_id)
    
    for user_movie_id in user_movie_ids
      unless movie_ids.include?(user_movie_id)
        user_movie = UsersMovie.find(:first,
          :conditions => ["user_id = ? and movie_id = ?",user_id,user_movie_id])
        user_movie.destroy
      end

    end
  end

  def self.get_common_movies_count(user_id_1, user_id_2)
    movies_user1 = UsersMovie.find_all_by_user_id(user_id_1).collect(&:movie_id)
    movies_user2 = UsersMovie.find_all_by_user_id(user_id_2).collect(&:movie_id)
    common_movies_ids = movies_user1 & movies_user2
    return common_movies_ids.size
  end
end
