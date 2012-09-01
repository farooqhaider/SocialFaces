class AlbumsController < ApplicationController
  layout 'profile'
  before_filter :authenticate_user!

  def index
    @user = current_user
    album_ids = UsersAlbum.find_all_by_user_id(@user.id).collect(&:album_id)
    @albums = Album.find_by_ids(album_ids)
  end

  
  def destroy
    @album = Album.find_by_id(params[:id])
    @album.destroy
    redirect_to :action => "index"
  end

  def post
    @album = Album.find_by_id(params[:id])
    @album.update_attributes(:posted => true)
    flash[:error_msg] = "The album has been successfully posted!"
    redirect_to :action => "show",:id =>params[:id]
  end
  
  def show
    @user = current_user
    #@user = User.find_by_id(params[:user_id])
    @album = Album.find_by_id(params[:id])
    puts params[:id]
    photo_ids = AlbumsPhoto.find_all_by_album_id(params[:id]).collect(&:photo_id)
    @photos = Photo.find_by_ids(photo_ids)
  end

  def edit_album
    @user = current_user
    albumid = params[:album_id]
    @album = Album.find_by_id(albumid)
    photo_ids = AlbumsPhoto.find_all_by_album_id(albumid).collect(&:photo_id)
    @photos = Photo.find_by_ids(photo_ids)

    @title = params[:title]
    @album_desc = params[:description]
    @album.update_attributes(:title => @title, :description => @album_desc)
    
    j = photo_ids.count
    i = 1
    for @photo in @photos
      @caption = params["caption"+i.to_s]
      @location = params["location"+i.to_s]
      @description = params["description"+i.to_s]
      @day = params[:day]
      @month = params[:month]
      @year = params[:year]
      dateis = "#{params[:day]} #{params[:month]} #{params[:year]}"
      @photo.update_attributes(:caption => @caption, :description => @description, :date_taken => dateis)
      i = i +1
    end
    redirect_to :action  => "show", :id => @album.id
    
  end

  def edit
    @user = current_user
    @album = Album.find_by_id(params[:id])
    photo_ids = AlbumsPhoto.find_all_by_album_id(params[:id]).collect(&:photo_id)
    @photos = Photo.find_by_ids(photo_ids)
  end

  def new
    @user = current_user
  end

  def create
    @user = current_user
    @title = params[:title]
    @description = params[:description]
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
    @photo = params[:photo]
    # Insert a new row for table "members" if value is not blank
    unless @title.blank?
      # Set the column named "user_name" to @name
      @upload = Photo.create({:image => @photo, :owner_id => @user.id, :quality => @quality, :followed => "false"})
      @album = Album.create({:title => @title.capitalize, :description =>@description,:owner_id => @user.id, :date_album => dateis, :quality => @res, :cover_photo => @upload.id})
      AlbumsPhoto.create({:album_id => @album.id, :photo_id => @upload.id})
      UsersAlbum.create({:user_id => @user.id,:album_id => @album.id})
      redirect_to :action  => "upload", :id => @album.id
    else
      redirect_to :action => "new"
    end
    #UsersAlbum.add_useralbum(current_user.id, params[:id])
  end

  def update
    @user = current_user
    @album = Album.find_by_id(params[:id])
    @album_id = UsersAlbum.find_by_user_id_and_album_id(@user.id ,@album.id)
    photo_ids = AlbumsPhoto.find_all_by_album_id(@album_id).collect(&:photo_id)
    @photos = Photo.find_by_ids(photo_ids)
  end


  def add_photos
    @user = current_user
    id = params[:id]
    @album = Album.find_by_id(params[:id])
    @album_id = UsersAlbum.find_by_user_id_and_album_id(@user.id ,@album.id)
    photo_ids = AlbumsPhoto.find_all_by_album_id(@album_id).collect(&:photo_id)
    @photos = Photo.find_by_ids(photo_ids)
    @photo = params[:photo]
    if !@photo.blank?
      @upload = Photo.create({:owner_id => @user.id, :quality => @album.quality})
      AlbumsPhoto.create({:album_id => @album.id, :photo_id => @upload.id})
      redirect_to :action  => "index", :id => @user.id
    else
      redirect_to :action => "add_photos", :id => @album_id
    end
  end

  def upload_photos
    @user = current_user
    albumid = params[:album_id]
    puts albumid
    i = 0
    while (i < 5)
      @photo = params["photo"+i.to_s]
      unless @photo.blank?
        @album = Album.find_by_id(albumid)
        @upload = Photo.create({:image => @photo, :owner_id => @user.id, :quality => @album.quality})
        AlbumsPhoto.create({:album_id => @album.id, :photo_id => @upload.id})
      end
      i = i +1
    end
    redirect_to :action  => "upload2", :id => @album.id
    #redirect_to :action => "upload", :id => @album.id
  end

  def upload2
    @user = current_user
    @album = Album.find_by_id(params[:id])
    photo_ids = AlbumsPhoto.find_all_by_album_id(params[:id]).collect(&:photo_id)
    @photos = Photo.find_by_ids(photo_ids)
  end

  def tag_photo
    @user = current_user
  end
  
  def add_description
    @user = current_user
    albumid = params[:album_id]
    @album = Album.find_by_id(albumid)
    photo_ids = AlbumsPhoto.find_all_by_album_id(albumid).collect(&:photo_id)
    @photos = Photo.find_by_ids(photo_ids)

    j = photo_ids.count
    i = 1
    for @photo in @photos
      @caption = params["caption"+i.to_s]
      @location = params["location"+i.to_s]
      @description = params["description"+i.to_s]
      @day = params[:day]
      @month = params[:month]
      @year = params[:year]
      dateis = "#{params[:day]} #{params[:month]} #{params[:year]}"
      @photo.update_attributes(:caption => @caption, :description => @description, :date_taken => dateis)
      i = i +1
    end
    redirect_to :action  => "show", :id => @album.id
  end
  
end
