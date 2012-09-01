class PhotosController < ApplicationController
  layout 'profile'
  before_filter :authenticate_user!
  #photos main page for a user
  def index
    @user = User.find_by_id(params[:id])
    album_ids = UsersAlbum.find_all_by_user_id(@user.id).collect(&:album_id)
    @albums = Album.find(:all, :conditions => ["id IN (?)", album_ids], :limit => 6)
  end

  def view_others_photos
    @user = User.find_by_id(params[:id])
    album_ids = UsersAlbum.find_all_by_user_id(@user.id).collect(&:album_id)
    @albums = Album.find(:all, :conditions => ["id IN (?)", album_ids], :limit => 6)
    render :action => "index"
  end

  def new
    @user = current_user
  end
  
  def destroy
    @photo = Photo.find_by_id(params[:id])
    @photo.destroy
    redirect_to :controller => "albums", :action => "index"
  end

  def show
    @user = current_user
    @photo = Photo.find_by_id(params[:id])
    tagged_people_ids = PhotosUser.find_all_by_photo_id(@photo.id).collect(&:user_id)
    @tagged_people = User.find_by_ids(tagged_people_ids)

    @tagged_people_pre = Array.new
    unless @tagged_people.blank?
      for user in @tagged_people
        if !(user.id.eql?(@user.id))
          @tagged_people_pre << {:id => user.id, :name => "#{user.first_name} #{user.last_name}"}
        end
      end
      @tagged_people_pre = @tagged_people_pre.to_json
    end
  end

  def tag_people
    photo_id = params[:photo_id].to_i
    photo = Photo.find_by_id(photo_id)
    user_id = photo.owner_id
    tagged_users = params[:tagged_users].split(',')

    tagged_user_ids = Array.new
    for tagged_user in tagged_users
      tagged_user_ids << tagged_user.to_i
    end
    if !tagged_users.include?(user_id)
      tagged_user_ids << user_id
    end
    PhotosUser.add_tagged_users(photo_id, tagged_user_ids) unless tagged_user_ids.blank?
    redirect_to :action => "show_photo", :id => photo_id
  end
  
  def gettaggedusers
    @user = current_user
    friend_ids = @user.friends.collect(&:friend_id)
    recent_tag_user_ids = PhotosUser.find(:all, :select => "distinct user_id",
      :conditions => ["user_id IN (?)",friend_ids],:order => "created_at desc").collect(&:user_id)
    user_ids = recent_tag_user_ids + (friend_ids - recent_tag_user_ids)
    users = User.find(:all, :conditions => ["(id IN (?)) AND (first_name like ? or last_name like ?)",
        user_ids,"%#{params[:q]}%","%#{params[:q]}%"])
    
    i = 0
    concatenated_name_users = Array.new
    for user in users
      if i < NUM_AUTOCOMPLETE_TAGGED_USERS
        concatenated_name_users << {:id => user.id, :name => "#{user.first_name} #{user.last_name}"}
        i+=1
      end
    end
    render :json => concatenated_name_users.to_json
  end
  def create
    @user = current_user
    @caption = params[:caption]
    @description = params[:description]
    @location = params[:location]
    #location_id
    puts @caption, @description
    @day = params[:day]
    @month = params[:month]
    @year = params[:year]
    dateis = "#{params[:day]} #{params[:month]} #{params[:year]}"
    @quality = params[:quality]
    @photo = params[:photo]
    puts "PHOTO : #{@photo}"
    # Insert a new row for table "members" if value is not blank
    if !@photo.blank?
      # Set the column named "user_name" to @name
      @album = Album.find_by_title_and_owner_id("Default Album", @user.id)
      Album.create_default_albums(@user) if @album.blank?
      @album = Album.find_by_title_and_owner_id("Default Album", @user.id)

      @photo = Photo.create({:image => @photo,:caption => @caption, :description =>@description,:owner_id => @user.id, :date_taken => dateis, :quality => @album.quality})
      AlbumsPhoto.create({:album_id => @album.id, :photo_id => @photo.id})
      redirect_to :action  => "show_photo", :id => @photo.id
    else
      flash[:error_msg] = "YOU GOT AN ERROR GO HOME"
      redirect_to :action  => "new"
    end

  end

  def upload_photo
    @user = current_user
    @caption = params[:caption]
    @description = params[:description]
    @location = params[:location]
    @day = params[:day]
    @month = params[:month]
    @year = params[:year]
    dateis = "#{params[:day]} #{params[:month]} #{params[:year]}"
    @quality = params[:quality]
    if @quality.eql?('on')
      @res = "high quality"
    else
      @res = "normal quality"
    end
    # Insert a new row for table "members" if value is not blank
    if !@caption.blank?
      # Set the column named "user_name" to @name
      @photo = Photo.create({:caption => @caption, :description =>@description,:owner_id => @user.id, :date_taken => dateis, :quality => @res})
      album = Album.find_by_title_and_owner_id("Default Album", @user.id)
      #agar default album nahi hai tau create ker dain..
      AlbumsPhoto.create({:album_id => album.id, :photo_id => @photo.id})
      redirect_to :action  => "photos", :id => @album.id
    else
      redirect_to :action  => "new"
    end
  end
end
  
  
