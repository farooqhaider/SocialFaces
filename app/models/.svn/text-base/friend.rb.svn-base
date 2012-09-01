class Friend < ActiveRecord::Base

  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"

  #Function to check whether the given user ids are friends or not
  def self.is_friend?(user, friend_user)
    friendship = Friend.find_by_user_id_and_friend_id(user.id,friend_user.id)
    return (friendship.blank?)? false : true
  end

  #Returns top ten friends according to alphabetical order
  def self.get_top_ten_friends(user)
    Friend.find(:all, :conditions => ["friends.user_id = ?",user.id],
      :include => :friend,
      :order => "users.first_name ASC", :limit => PROFILE_TOP_FRIENDS_COUNT)
  end

  #Adding friend
  def self.add_friend(user,friend_user)
    Friend.create!(:user_id => user.id, :friend_id => friend_user.id)
    friendship = Friend.create!(:user_id => friend_user.id, :friend_id => user.id)
    return friendship
  end

  #Removing Friend
  def self.remove_friend(user,friend_user)
    friendship_to_remove = Friend.find_by_user_id_and_friend_id(user.id, friend_user.id)
    friendship_to_remove.destroy unless friendship_to_remove.blank?
    friendship_to_remove = Friend.find_by_user_id_and_friend_id(friend_user.id, user.id)
    friendship_to_remove.destroy unless friendship_to_remove.blank?
  end

  #Returns mutual friend ids between two users
  def self.mutual_friend_ids(user1,user2)
    friends_user1 = Friend.find_all_by_user_id(user1.id).collect(&:friend_id)
    friends_user2 = Friend.find_all_by_user_id(user2.id).collect(&:friend_id)
    mutual_friend_ids = friends_user1 & friends_user2
    return mutual_friend_ids.shuffle
  end

  def self.get_friend_suggestions(user)
    suggestions = Array.new
    friends_sorted = Friend.get_suggestee_friends_score(user.id)
    unless friends_sorted.blank?
      i = 0
      while (i < friends_sorted.size and suggestions.size < TOTAL_SUGGESTIONS_COUNT)
        friend_id = friends_sorted[i][0]
        friends_of_friends_sorted = Friend.get_suggestee_friends_of_friends_score(user.id,friend_id)
        j = 0
        while (j < PER_FRIEND_SUGGESTIONS_COUNT and j < friends_of_friends_sorted.size)
          suggestion_u_id = friends_of_friends_sorted[j][0]
          suggestions <<  suggestion_u_id if suggestions.size < TOTAL_SUGGESTIONS_COUNT
          j += 1
        end
        i += 1
      end 
    end
    suggestions = suggestions.uniq
    return suggestions.shuffle
  end

  #going to find the closest friends of user
  def self.get_suggestee_friends_score(user_id)
    user = User.find_by_id(user_id)
    user_friend_ids = user.friends.collect(&:friend_id)

    friends_score = {}
    for friend_id in user_friend_ids
      friend_user = User.find_by_id(friend_id)
      score = 0

      scores = Friend.get_common_scores(user, friend_user)

      score = ((scores["mutual_friends"]/NORMALIZE_VALUE) * MUTUAL_FRIEND_WEIGHTAGE_1) +
        ((scores["common_employers"]/NORMALIZE_VALUE) * WORKPLACE_WEIGHTAGE_1) +
        ((scores["common_education"]/NORMALIZE_VALUE) * EDUCATION_WEIGHTAGE_1) +
        ((scores["common_commented_posts"]/NORMALIZE_VALUE) * COMMENTED_POSTS_WEIGHTAGE_1) +
        ((scores["common_liked_posts"]/NORMALIZE_VALUE) * LIKED_POSTS_WEIGHTAGE_1) +
        ((scores["coappearance"]/NORMALIZE_VALUE) * COAPPEARANCE_WEIGHTAGE_1) +
        ((scores["profile_visits"]/NORMALIZE_VALUE) * PROFILE_VISITS_WEGIHTAGE_1) +
        ((scores["curr_location"]/NORMALIZE_VALUE) * CURRENT_LOCATION_WEIGHTAGE_1) +
        ((scores["hometown"]/NORMALIZE_VALUE) * HOMETOWN_WEIGHTAGE_1)

      friends_score[friend_id] = score
      
    end
    friends_array_sorted = friends_score.sort_by {|k,v| v}
    return friends_array_sorted.reverse
  end

  #going to find the closest friends of friends of user
  def self.get_suggestee_friends_of_friends_score(user_id,friend_id)
    user = User.find_by_id(user_id)
    friend_user = User.find_by_id(friend_id)
    friend_ids = user.friends.collect(&:friend_id)
    friend_of_friend_ids = friend_user.friends.collect(&:friend_id)
    friend_of_friend_ids = friend_of_friend_ids - friend_ids - [user_id]
    friends_score = {}
    for friend_of_friend_id in friend_of_friend_ids
      friend_of_friend_user = User.find_by_id(friend_of_friend_id)
      score = 0

      common_scores = Friend.get_common_scores(user, friend_of_friend_user)

      interested_in_score = 0
      if user.interested_in.eql?('both')
        interested_in_score = NORMALIZE_VALUE
      elsif (user.interested_in.eql?('men') and friend_of_friend_user.gender.eql?('male'))
        interested_in_score = NORMALIZE_VALUE
      elsif (user.interested_in.eql?('women') and friend_of_friend_user.gender.eql?('female'))
        interested_in_score = NORMALIZE_VALUE
      end

      common_lists_count = UsersList.get_common_lists_count(friend_id, friend_of_friend_id, user_id)
      unless common_lists_count.eql?(0)
      total_lists_count = friend_of_friend_user.lists.size
      common_lists_score = (common_lists_count/total_lists_count)*NORMALIZE_VALUE
      else
        common_lists_score = 0
      end
      

      common_activities_count = UsersActivity.get_common_activities_count(user_id, friend_of_friend_id)
      unless common_activities_count.eql?(0)
      total_activities_count = user.activities.size
      common_activities_score = (common_activities_count/total_activities_count)*NORMALIZE_VALUE
      else
        common_activities_score = 0
      end
      
      common_interests_count = UsersInterest.get_common_interests_count(user_id, friend_of_friend_id)
      unless common_interests_count.eql?(0)
      total_interests_count = user.intersts.size
      common_interests_score = (common_interests_count/total_interests_count)*NORMALIZE_VALUE
      else
        common_interests_score = 0
      end
      
      common_sports_count = UsersSport.get_common_sports_count(user_id, friend_of_friend_id)
      unless common_sports_count.eql?(0)
      total_sports_count = user.sports.size
      common_sports_score = (common_sports_count/total_sports_count)*NORMALIZE_VALUE
      else
        common_sports_score = 0
      end
      
      common_games_count = UsersGame.get_common_games_count(user_id, friend_of_friend_id)
      unless common_games_count.eql?(0)
      total_games_count = user.games.size
      common_games_score = (common_games_count/total_games_count)*NORMALIZE_VALUE
      else
        common_games_score = 0
      end
      
      common_teams_count = UsersTeam.get_common_teams_count(user_id, friend_of_friend_id)
      unless common_teams_count.eql?(0)
      total_teams_count = user.teams.size
      common_teams_score = (common_teams_count/total_teams_count)*NORMALIZE_VALUE
      else
        common_teams_score = 0
      end
      

      common_musics_count = UsersMusic.get_common_musics_count(user_id, friend_of_friend_id)
      unless common_musics_count.eql?(0)
      total_musics_count = user.musics.size
      common_musics_score = (common_musics_count/total_musics_count)*NORMALIZE_VALUE
      else
        common_musics_score = 0
      end
      

      common_movies_count = UsersMovie.get_common_movies_count(user_id, friend_of_friend_id)
      unless common_movies_count.eql?(0)
      total_movies_count = user.movies.size
      common_movies_score = (common_movies_count/total_movies_count)*NORMALIZE_VALUE
      else
        common_movies_score = 0
      end
      
      common_languages_count = UsersLanguage.get_common_languages_count(user_id, friend_of_friend_id)
      unless common_languages_count.eql?(0)
      total_languages_count = user.languages.size
      common_languages_score = (common_languages_count/total_languages_count)*NORMALIZE_VALUE
      else
        common_languages_score = 0
      end
      
      common_tv_shows_count = UsersTvShow.get_common_tv_shows_count(user_id, friend_of_friend_id)
      unless common_tv_shows_count.eql?(0)
      total_tv_shows_count = user.tv_shows.size
      common_tv_shows_score = (common_tv_shows_count/total_tv_shows_count)*NORMALIZE_VALUE
      else
        common_tv_shows_score = 0
      end
      
      common_athletes_count = UsersAthlete.get_common_athletes_count(user_id, friend_of_friend_id)
      unless common_athletes_count.eql?(0)
      total_athletes_count = user.athletes.size
      common_athletes_score = (common_athletes_count/total_athletes_count)*NORMALIZE_VALUE
      else
        common_athletes_score = 0
      end
      

      common_books_count = UsersBook.get_common_books_count(user_id, friend_of_friend_id)
      unless common_books_count.eql?(0)
      total_books_count = user.books.size
      common_books_score = (common_books_count/total_books_count)*NORMALIZE_VALUE
      else
        common_books_score = 0
      end
      
      score = ((common_scores["mutual_friends"]/NORMALIZE_VALUE) * MUTUAL_FRIEND_WEIGHTAGE_2) +
        ((common_scores["common_employers"]/NORMALIZE_VALUE) * WORKPLACE_WEIGHTAGE_2) +
        ((common_scores["common_education"]/NORMALIZE_VALUE) * EDUCATION_WEIGHTAGE_2) +
        ((common_scores["common_commented_posts"]/NORMALIZE_VALUE) * COMMENTED_POSTS_WEIGHTAGE_2) +
        ((common_scores["common_liked_posts"]/NORMALIZE_VALUE) * LIKED_POSTS_WEIGHTAGE_2) +
        ((common_scores["coappearance"]/NORMALIZE_VALUE) * COAPPEARANCE_WEIGHTAGE_2) +
        ((common_scores["profile_visits"]/NORMALIZE_VALUE) * PROFILE_VISITS_WEGIHTAGE_2) +
        ((common_scores["curr_location"]/NORMALIZE_VALUE) * CURRENT_LOCATION_WEIGHTAGE_2) +
        ((common_scores["hometown"]/NORMALIZE_VALUE) * HOMETOWN_WEIGHTAGE_2) +
        ((interested_in_score/NORMALIZE_VALUE) * INTERESTED_IN_WEIGHTAGE) +
        ((common_lists_score/NORMALIZE_VALUE) * SAME_LISTS_WEIGHTAGE) +
        ((common_activities_score/NORMALIZE_VALUE) * COMMON_ACTIVITIES_WEIGHTAGE) +
        ((common_interests_score/NORMALIZE_VALUE) * COMMON_INTERESTS_WEIGHTAGE) +
        ((common_sports_score/NORMALIZE_VALUE) * COMMON_SPORTS_WEIGHTAGE) +
        ((common_games_score/NORMALIZE_VALUE) * COMMON_GAMES_WEIGHTAGE) +
        ((common_teams_score/NORMALIZE_VALUE) * COMMON_TEAMS_WEIGHTAGE) +
        ((common_musics_score/NORMALIZE_VALUE) * COMMON_MUSICS_WEIGHTAGE) +
        ((common_movies_score/NORMALIZE_VALUE) * COMMON_MOVIES_WEIGHTAGE) +
        ((common_languages_score/NORMALIZE_VALUE) * COMMON_LANGUAGES_WEIGHTAGE) +
        ((common_tv_shows_score/NORMALIZE_VALUE) * COMMON_TV_SHOWS_WEIGHTAGE) +
        ((common_athletes_score/NORMALIZE_VALUE) * COMMON_ATHLETES_WEIGHTAGE) +
        ((common_books_score/NORMALIZE_VALUE) * COMMON_BOOKS_WEIGHTAGE)

      friends_score[friend_of_friend_id] = score

    end
    friends_array_sorted = friends_score.sort_by {|k,v| v}
    return friends_array_sorted.reverse
  end

  def self.get_common_scores(user,friend_user)

    user_id = user.id
    friend_id = friend_user.id
    user_friend_ids = user.friends.collect(&:friend_id)
    scores = {}
    mutual_friends_count = (Friend.mutual_friend_ids(user,friend_user)).size
    unless mutual_friends_count.eql?(0)
      total_friends_count = user_friend_ids.size
      scores["mutual_friends"] = (mutual_friends_count/total_friends_count)*NORMALIZE_VALUE
    else
      scores["mutual_friends"] = 0
    end

    common_employers_count = UsersEmployer.get_common_employers_count(user_id, friend_id)
    unless common_employers_count.eql?(0)
      total_employers_count = user.employers.size
      scores["common_employers"] = (common_employers_count/total_employers_count)*NORMALIZE_VALUE
    else
      scores["common_employers"] = 0
    end


    common_schools_count = UsersSchool.get_common_schools_count(user_id, friend_id)
    total_schools_count = user.schools.size

    common_universities_count = UsersUniversity.get_common_universities_count(user_id, friend_id)
    total_universities_count = user.universities.size
    common_education_count = common_schools_count + common_universities_count
    unless common_education_count.eql?(0)
      total_education_count = total_schools_count + total_universities_count

      scores["common_education"] = (common_education_count/total_education_count)*NORMALIZE_VALUE
    else
      scores["common_education"] = 0
    end

    common_commented_posts_count = Comment.get_common_commented_posts_count(user, friend_user)
    unless common_commented_posts_count.eql?(0)
      total_commented_posts_count = (Comment.find_all_by_commentee_user_id(user_id)).size
      scores["common_commented_posts"] = (common_commented_posts_count/total_commented_posts_count)*NORMALIZE_VALUE
    else
      scores["common_commented_posts"] = 0
    end


    common_liked_posts_count = Like.get_common_liked_posts_count(user, friend_user)
    unless common_liked_posts_count.eql?(0)
      total_liked_posts_count = (Like.find_all_by_like_user_id(user_id)).size
      scores["common_liked_posts"] = (common_liked_posts_count/total_liked_posts_count)*NORMALIZE_VALUE
    else
      scores["common_liked_posts"] = 0
    end


    coappearance_photos_count = PhotosUser.get_coappearance_photos_count(user, friend_user)
    total_photos_count = (PhotosUser.find_all_by_user_id(user_id)).size

    coappearance_videos_count = VideosUser.get_coappearance_videos_count(user_id, friend_id)
    total_videos_count = (VideosUser.find_all_by_user_id(user_id)).size

    coappearance_albums_count = AlbumsTaggedUser.get_coappearance_albums_count(user, friend_user)
    total_albums_count = (AlbumsTaggedUser.find_all_by_user_id(user_id)).size

    coappearance_count = coappearance_photos_count+coappearance_videos_count+coappearance_albums_count
    unless coappearance_count.eql?(0)
      total_count = total_photos_count + total_videos_count + total_albums_count
      scores["coappearance"] = (coappearance_count/total_count)*NORMALIZE_VALUE
    else
      scores["coappearance"] = 0
    end


    freq_profile_visits_count = ProfileVisit.get_profile_visit_count(user,friend_user)
    unless freq_profile_visits_count.eql?(0)
      total_profile_visits_count = ProfileVisit.sum("count", :conditions => ["user_id = ?",user_id])
      scores["profile_visits"] = (freq_profile_visits_count/total_profile_visits_count)*NORMALIZE_VALUE
    else
      scores["profile_visits"] = 0
    end

    scores["curr_location"] = 0
    scores["hometown"] = 0
    if (user.current_location_id.eql?(friend_user.current_location_id))
      scores["curr_location"] = NORMALIZE_VALUE
    end
    if (user.hometown_id.eql?(friend_user.hometown_id))
      scores["hometown"] = NORMALIZE_VALUE
    end

    return scores
  end
  def self.get_friends_search_results(user_id,friend_user_ids)
    results = Friend.find(:all,
      :conditions => ["user_id = ? and friend_id IN (?)",user_id,friend_user_ids])
    return results
  end
end
