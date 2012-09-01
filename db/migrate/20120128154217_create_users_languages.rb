class CreateUsersLanguages < ActiveRecord::Migration
  def self.up
    create_table :users_languages do |t|
      t.integer :user_id
      t.integer :language_id
    end
  end

  def self.down
    drop_table :users_languages
  end
end
