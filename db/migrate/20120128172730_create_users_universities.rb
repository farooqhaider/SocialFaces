class CreateUsersUniversities < ActiveRecord::Migration
  def self.up
    create_table :users_universities do |t|
      t.integer :user_id
      t.integer :university_id
      t.string :position
      t.integer :location_id
      t.text :description

      t.integer :from_day
      t.string :from_month
      t.integer :from_year

      t.integer :to_day
      t.string :to_month
      t.integer :to_year
      t.boolean :graduated

      t.string :course_1
      t.string :coures_2
      t.string :course_3
      t.boolean :attended_for #0 for uni , 1 for post grad
      t.string :postgrad_degree #e.g. HR , empty if not post grad

    end
  end

  def self.down
    drop_table :users_universities
  end
end
