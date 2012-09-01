class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
     t.string   :title
     t.string   :description
     t.integer  :location_id
     t.datetime :date_album
     t.string   :quality
     t.boolean  :followed
     t.boolean  :posted
     t.integer  :cover_photo
     t.integer  :owner_id

     t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
