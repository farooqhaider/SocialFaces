class ChangeComments < ActiveRecord::Migration
  def self.up
    remove_column :comments, :item_id
    remove_column :comments, :user_id
    remove_column :comments, :item_type
    add_column :comments, :post_id, :integer
  end

  def self.down
    add_column :comments, :item_id, :integer
    add_column :comments, :user_id, :integer
    add_column :comments, :item_type, :string
    remove_column :comments, :post_id
  end
end
