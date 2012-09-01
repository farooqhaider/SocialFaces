class PostsUser < ActiveRecord::Base

  def self.get_coappearance_post_count(user1, user2)
    photos_user1 = PhotosUser.find_all_by_user_id(user1.id).collect(&:photo_id)
    photos_user2 = PhotosUser.find_all_by_user_id(user2.id).collect(&:photo_id)
    common_photos_ids = photos_user1 & photos_user2
    return common_photos_ids.size
  end

  def self.add_tagged_users(post_id, tagged_user_ids)
    for tagged_user_id in tagged_user_ids
      post_user = PostsUser.find_by_post_id_and_user_id(post_id, tagged_user_id)
      if post_user.blank?
        post_user = PostsUser.create!(:post_id => post_id, :user_id => tagged_user_id)
        Feed.create!(:user_id => tagged_user_id, :post_id => post_user.id, :feed_type => FEED_TYPE_TAG)
      end
    end
  end


end