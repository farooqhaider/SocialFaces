class Photo < ActiveRecord::Base
 belongs_to :album
  
 has_one :cover_photo, :class_name => "Album"
 has_attached_file :image,
                     :styles => {
                       :thumb => "160x120>",
                       :small => "250x250>"
                    }
	validates_attachment_size :image, :less_than=> 4.megabytes
  validates_attachment_content_type :image, :content_type=>['image/jpeg', 'image/png', 'image/gif']

  has_many :users, :through => :photos_users

  def self.find_by_ids(photo_ids)
    photos = Photo.find(:all, :conditions => ["id IN (?)",photo_ids])
    return photos
  end
  
end