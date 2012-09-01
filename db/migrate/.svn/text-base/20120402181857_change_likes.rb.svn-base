class ChangeLikes < ActiveRecord::Migration
  def self.up
    remove_column :likes, :item_id
    remove_column :likes, :user_id
    remove_column :likes, :item_type
    add_column :likes, :post_id, :integer

  end

  def self.down
    add_column :likes, :item_id, :integer
    add_column :likes, :user_id, :integer
    add_column :likes, :item_type, :string
    remove_column :likes, :post_id
  end
end
