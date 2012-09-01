class PhotosUser < ActiveRecord::Base

  def self.get_coappearance_photos_count(user1, user2)
    photos_user1 = PhotosUser.find_all_by_user_id(user1.id).collect(&:photo_id)
    photos_user2 = PhotosUser.find_all_by_user_id(user2.id).collect(&:photo_id)
    common_photos_ids = photos_user1 & photos_user2
    return common_photos_ids.size
  end

  def self.add_tagged_users(photo_id, tagged_user_ids)
    for tagged_user_id in tagged_user_ids
      photo_user = PhotosUser.find_by_photo_id_and_user_id(photo_id, tagged_user_id)
      if photo_user.blank?
        PhotosUser.create!(:photo_id => photo_id, :user_id => tagged_user_id)
      end
    end
  end

  
end