class CreateFriendSuggestions < ActiveRecord::Migration
  def self.up
    create_table :friend_suggestions do |t|
      t.integer :suggestor_user_id
      t.integer :suggested_user_id
      t.integer :suggestee_user_id
    end
  end

  def self.down
    drop_table :friend_suggestions
  end
end
