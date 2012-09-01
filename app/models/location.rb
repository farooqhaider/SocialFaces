class Location < ActiveRecord::Base
  has_many :users

  def self.create_new(new_location)
    location = Location.create!(:name => new_location)
    return location
  end
end
