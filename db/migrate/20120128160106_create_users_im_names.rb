class CreateUsersImNames < ActiveRecord::Migration
  def self.up
    create_table :users_im_names do |t|
      t.integer :user_id
      t.string :im_agent_id
      t.string :im_name
    end
  end

  def self.down
    drop_table :users_im_names
  end
end
