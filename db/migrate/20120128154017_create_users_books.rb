class CreateUsersBooks < ActiveRecord::Migration
  def self.up
    create_table :users_books do |t|
      t.integer :user_id
      t.integer :book_id
    end
  end

  def self.down
    drop_table :users_books
  end
end
