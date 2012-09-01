class CreateUserAccounts < ActiveRecord::Migration
  def self.up
    create_table :user_accounts do |t|
      t.string :email
      t.string :password
      t.integer :user_profiles_id
      t.timestamps
    end
  end

  def self.down
    drop_table :user_accounts
  end
end
