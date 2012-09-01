class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|

      t.integer :user_id
      t.integer :post_id
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
