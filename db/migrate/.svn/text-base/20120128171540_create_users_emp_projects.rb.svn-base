class CreateUsersEmpProjects < ActiveRecord::Migration
  def self.up
    create_table :users_emp_projects do |t|
      t.integer :user_employer_id
      t.string :name
      t.text :description

      t.integer :from_day
      t.string :from_month
      t.integer :from_year

      t.integer :to_day
      t.string :to_month
      t.integer :to_year
      t.boolean :currently_working
    end
  end

  def self.down
    drop_table :users_emp_projects
  end
end
