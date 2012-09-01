class RenameUserVideosAndAddingCountProfileVisits < ActiveRecord::Migration
  def self.up
    rename_table :users_videos , :videos_users
    add_column :profile_visits, :count, :integer
  end

  def self.down
    rename_table :videos_users , :users_videos
    remove_column :profile_visits, :count
  end
end
