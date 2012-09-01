class CreateImAgents < ActiveRecord::Migration
  def self.up
    create_table :im_agents do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :im_agents
  end
end
