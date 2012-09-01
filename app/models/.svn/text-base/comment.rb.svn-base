class Comment < ActiveRecord::Base
  
  def self.get_common_commented_posts_count(user1, user2)
    comments_user1 = Comment.find_all_by_commentee_user_id(user1.id).collect(&:post_id)
    comments_user2 = Comment.find_all_by_commentee_user_id(user2.id).collect(&:post_id)
    common_comments_ids = comments_user1 & comments_user2
    return common_comments_ids.size
  end

  def self.get_common_commented_posts(user1, user2)
    comments_user1 = Comment.find_all_by_commentee_user_id(user1.id).collect(&:post_id)
    comments_user2 = Comment.find_all_by_commentee_user_id(user2.id).collect(&:post_id)
    common_comments_ids = comments_user1 & comments_user2
    return common_comments_ids
  end

  def self.get_commented_on_others_post(user1, user2)
    posts_by_user1 = Comment.find(:all, :conditions => ["commentee_user_id = (?) and user_id =(?)",user1.id, user2.id])
    posts_by_user2 = Comment.find(:all, :conditions => ["commentee_user_id = (?) and user_id =(?)",user2.id, user1.id])
    commented_posts = posts_by_user1 + posts_by_user2
    return commented_posts
  end

end