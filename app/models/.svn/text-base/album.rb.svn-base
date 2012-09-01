class Album < ActiveRecord::Base
  has_many :tagged_people, :class_name => "User", :through => :albums_users
  has_many :albums_users
  has_many :albums_photos
  
  has_many :photos, :through => :albums_photos
  belongs_to :cover, :class_name => "Photo", :foreign_key => "cover_photo"
  #has_many:photos, :class_name => "Photo", :through => :albums_photos, :dependent => :destroy
  accepts_nested_attributes_for :photos, :allow_destroy => true
  
  def self.create_default_albums(user)
      user_id = user.id
      album1 = Album.create(:title => "Default Album" , :owner_id => user_id)
      album2 = Album.create(:title => "Profile Picture" , :owner_id => user_id)
      album3 = Album.create(:title => "Wall Photos" , :owner_id => user_id)
      UsersAlbum.create(:user_id => user_id , :album_id => album1.id)
      UsersAlbum.create(:user_id => user_id , :album_id => album2.id)
      UsersAlbum.create(:user_id => user_id , :album_id => album3.id)
  end
  def self.find_by_ids(album_ids)
    albums = Album.find(:all, :conditions => ["id IN (?)",album_ids])
    return albums
  end
end
