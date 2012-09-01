class CreateUsersEmails < ActiveRecord::Migration
  def self.up
    create_table :users_emails do |t|
      t.integer :user_id
      t.string :email_id
    end
  end

  def self.down
    drop_table :users_emails
  end
end
