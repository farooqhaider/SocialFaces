class CreateEmployers < ActiveRecord::Migration
  def self.up
    create_table :employers do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :employers
  end
end
