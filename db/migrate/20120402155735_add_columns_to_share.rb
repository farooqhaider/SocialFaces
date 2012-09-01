class AddColumnsToShare < ActiveRecord::Migration
  def self.up
    add_column :shares, :shared_by_id, :integer
    add_column :shares, :shared_with_id, :integer
  end

  def self.down
    remove_column :shares, :shared_by_id, :integer
    remove_column :shares, :shared_with_id, :integer
  end
end
