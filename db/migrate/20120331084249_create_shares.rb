class CreateShares < ActiveRecord::Migration
  def self.up
    create_table :shares do |t|
      t.string :caption
      t.text :description
      t.text :text
      t.integer :location_id
      t.integer :post_id
      t.date :date
      t.timestamps
    end
  end

  def self.down
  end
end
