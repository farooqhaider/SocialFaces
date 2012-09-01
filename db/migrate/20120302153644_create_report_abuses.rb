class CreateReportAbuses < ActiveRecord::Migration
  def self.up
    create_table :report_abuses do |t|
      t.integer :reported_item_id
      t.string :item_type
      t.integer :reported_by_user_id
      t.string :description
    end
  end

  def self.down
    drop_table :report_abuses
  end
end
