class CreatePhotos < ActiveRecord::Migration
  #table to save information about each individual photo in the system
  def self.up
   create_table :photos do |t|
     t.string   :caption
     t.string   :description
     t.integer  :location_id
     t.datetime :date_taken
     t.string   :quality
     t.boolean  :followed
     t.boolean  :posted
     t.string   :current_state
     t.integer  :owner_id

     t.timestamps
     #the photos, their url, updation date, n type
     # will be added by the paperclip plugin automatically
   end

  end

  def self.down
    drop_table :photos
  end
end
