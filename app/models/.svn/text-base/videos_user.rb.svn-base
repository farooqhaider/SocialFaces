class VideosUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :video

  def self.get_coappearance_videos_count(user_id_1, user_id_2)
    videos_user1 = VideosUser.find_all_by_user_id(user_id_1).collect(&:video_id)
    videos_user2 = VideosUser.find_all_by_user_id(user_id_2).collect(&:video_id)
    common_videos_ids = videos_user1 & videos_user2
    return common_videos_ids.size
  end
end