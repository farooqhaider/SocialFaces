class CreateUnsubscriptions < ActiveRecord::Migration
  def self.up
    create_table :unsubscriptions do |t|

      t.integer :user_id
      t.integer :unsubscribed_user_id
      t.string :feed_type

      t.timestamps
    end
  end

  def self.down
    drop_table :unsubscriptions
  end
end
