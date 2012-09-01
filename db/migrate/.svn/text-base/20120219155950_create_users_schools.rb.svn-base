class CreateUsersSchools < ActiveRecord::Migration
  def self.up
    create_table :users_schools do |t|
      t.integer :user_id
      t.integer :school_id
    end
    add_index :users_schools, [:user_id,:school_id]
  end

  def self.down
    drop_table :users_schools
  end
end
