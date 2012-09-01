class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.text :description
      t.integer :user_id
      t.integer :checked, :default => 0
      t.string :post_id
      t.timestamps
    end
  end

  def self.down
     drop_table :notifications
  end
end
