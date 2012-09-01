class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both

      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :dob
      t.string :gender

      t.string :adress_zipcode
      t.string :address_neighbourhood
      t.text :address
      t.integer :address_towncity

      t.string :interested_in
      t.string :alternate_name

      t.integer :religion_id
      t.text :religion_desc

      t.integer :political_view_id
      t.text :political_views_desc
      t.text :favorite_quotes
      t.text :about_me
      t.string :relationship_status
      t.integer :current_location_id
      t.integer :hometown_id
      t.text :website

      t.string :display_as


      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end
