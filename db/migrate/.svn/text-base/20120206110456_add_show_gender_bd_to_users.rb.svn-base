class AddShowGenderBdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :show_gender, :string
    add_column :users, :show_bd, :string
    rename_column :users_musics, :musics_id, :music_id
    rename_column :users_tv_shows, :tv_shows_id, :tv_show_id
  end

  def self.down
    remove_column :users, :show_gender
    remove_column :users, :show_bd
    rename_column :users_musics, :music_id, :musics_id
    rename_column :users_tv_shows, :tv_show_id, :tv_shows_id
  end
end
