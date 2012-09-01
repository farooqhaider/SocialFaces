class AlbumsTaggedUser < ActiveRecord::Base
  belongs_to :albums
  belongs_to :tagged_people, :class_name => 'User', :foreign_key => "user_id"

  def self.get_coappearance_albums_count(user1, user2)
    albums_user1 = AlbumsTaggedUser.find_all_by_user_id(user1.id).collect(&:album_id)
    albums_user2 = AlbumsTaggedUser.find_all_by_user_id(user2.id).collect(&:album_id)
    common_albums_ids = albums_user1 & albums_user2
    return common_albums_ids.size
  end
end
