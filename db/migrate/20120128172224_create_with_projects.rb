class CreateWithProjects < ActiveRecord::Migration
  def self.up
    create_table :with_projects do |t|
      t.integer :user_emp_project_id
      t.integer :with_user_id
    end
  end

  def self.down
    drop_table :with_projects
  end
end
