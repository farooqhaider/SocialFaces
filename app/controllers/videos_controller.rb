require "utility"
class VideosController < ApplicationController
   layout 'profile'
   before_filter :authenticate_user!
 
  def new
     @user = current_user
     @video = Video.new

  end

  def create

    @video = Video.new(params[:video])
    @video.user_id = current_user.id

    if @video.save
      @video.convert
      flash[:notice] = "Video has been uploaded"
    end

    redirect_to :controller=>'photos', :action => 'index'# 'photos/photos'
  end

  def show
    @user = current_user
    @videos = Video.find_all_by_user_id(@user.id)
  end

  def edit
    @user = current_user
    @video = Video.find(params[:id])
  end

  def update
     @video = Video.find(params[:id])
     @video.title = params[:title]
     @video.description = params[:description]
     @video.caption = params[:caption]
     @video.location = params[:location]
     str = "#{params[:day]}/#{Utility.conv_month_to_num(params[:month])}/#{params[:year]}"
     date = Date.strptime(str, "%d/%m/%Y")
     @video.date= date
     @video.save()
     redirect_to :action  => "display", :id => @video.id
  end

 def display
   @user = current_user
   @video = Video.find(params[:id])
 end

end