class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :item_ids
      t.integer :user_id #jiski post thee
      t.integer :commentee_user_id  #who commented
      t.string :description
      t.string :item_type
    end
  end

  def self.down
    drop_table :comments
  end
end
