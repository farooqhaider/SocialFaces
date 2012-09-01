class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.string :name
    end
    add_index :lists, :name
  end

  def self.down
    drop_table :lists 
  end
end
