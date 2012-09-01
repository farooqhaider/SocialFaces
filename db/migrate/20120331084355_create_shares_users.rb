class CreateSharesUsers < ActiveRecord::Migration
  def self.up
    create_table :shares_users do |t|
      t.integer :user_id
      t.integer :share_id
      t.timestamps
    end
  end

  def self.down
    drop_table :shares_users
  end
end
