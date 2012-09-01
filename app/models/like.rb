class Like < ActiveRecord::Base

  def self.get_common_liked_posts_count(user1, user2)
    likes_user1 = Like.find_all_by_like_user_id(user1.id).collect(&:post_id)
    likes_user2 = Like.find_all_by_like_user_id(user2.id).collect(&:post_id)
    common_likes_ids = likes_user1 & likes_user2
    return common_likes_ids.size
  end
  
end