class ChangeFeedTypeColumnName < ActiveRecord::Migration
  def self.up
    rename_column :feeds, :type, :feed_type
  end

  def self.down
    rename_column :feeds, :feed_type, :type
  end
end
