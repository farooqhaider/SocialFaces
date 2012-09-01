class UsersController < ApplicationController
  respond_to :html, :xml, :json, :js
  layout 'profile'
  before_filter :authenticate_user!
  #View own profile action
  def show_profile
    @user = current_user
    @friends = Friend.get_top_ten_friends(@user)
    suggestion_ids = Friend.get_friend_suggestions(@user)
    @suggested_users = User.find_by_ids(suggestion_ids)
    UsersList.create_default_lists(@user.id) if @user.lists.blank?
    Album.create_default_albums(@user) if @user.albums.blank?
  end

  def friend_suggestions
    @user = current_user
    @suggestions = FriendSuggestion.find_by_suggestee_user_id(@user.id)
  end

  def mutual_friends
    @user = current_user
    user = User.find_by_id(params[:id])
    mutual_friend_ids = Friend.mutual_friend_ids(@user, user)
    @mutual_friends = User.get_paginated_mutual_friends(mutual_friend_ids,params[:page])
  end

  def set_sugg_checkboxes(suggested_users)
    @sugg_users_hometowns = Array.new
    @sugg_users_curr_locations = Array.new
    @sugg_users_employers = Array.new
    @sugg_users_mutual_friends = Array.new
    @sugg_users_universities = Array.new
    for suggested_user in suggested_users
      hometown = Location.find_by_id(suggested_user.hometown_id)
      unless hometown.blank?
        @sugg_users_hometowns << hometown.name unless @sugg_users_hometowns.include?(hometown.name)
      end
      curr_location = Location.find_by_id(suggested_user.current_location_id)
      unless curr_location.blank?
        @sugg_users_curr_locations << curr_location.name unless @sugg_users_curr_locations.include?(curr_location.name)
      end
      unless suggested_user.employers.blank?
        @sugg_users_employers << suggested_user.employers.first.name unless @sugg_users_employers.include?(suggested_user.employers.first.name)
      end
      unless suggested_user.universities.blank?
        @sugg_users_universities << suggested_user.universities.first.name unless @sugg_users_universities.include?(suggested_user.universities.first.name)
      end

      mutual_friends = Friend.mutual_friend_ids(@user, suggested_user)
      for mutual_friend_id in mutual_friends
        user = User.find_by_id(mutual_friend_id)
        name = "#{user.first_name} #{user.last_name}"
        @sugg_users_mutual_friends << name unless @sugg_users_mutual_friends.include?(name)
      end
    end
  end
  
  def all_suggestions
    @user = current_user
    suggestion_ids = Friend.get_friend_suggestions(@user)
    @suggested_users = User.find_by_ids(suggestion_ids)
    
    set_sugg_checkboxes(@suggested_users)
  end
 
  def suggest_friends
    @user = current_user
    @suggestee = User.find_by_id(params[:id])
    mutual_friend_ids = Friend.mutual_friend_ids(@user, @suggestee)
    friend_ids = (@user.friends.collect(&:friend_id)) - mutual_friend_ids - [@suggestee.id]
    @friend_users = User.find_by_ids(friend_ids)
    suggestion_ids = (Friend.get_friend_suggestions(@suggestee)) & friend_ids
    @suggested_users = User.find_by_ids(suggestion_ids)
  end

  def getsuggestions
    @user = current_user
    friend_ids = @user.friends.collect(&:friend_id)
    friend_users = User.get_friends_autocomplete(friend_ids,params[:q])
    full_name_users = get_users_full_names_with_ids(friend_users)
    
    render :json => full_name_users.to_json
  end

  def get_users_full_names_with_ids(users)
  
    full_name_users = Array.new
    for user in users
      full_name_users << {:id => user.id, :name => "#{user.first_name} #{user.last_name}"}
    end
    return full_name_users
  end

  def suggest_to_user
    suggestor = current_user
    suggestee_id = params[:suggestee_id].to_i
    mutual_friend_ids = Friend.mutual_friend_ids(suggestor, suggestee)
    suggested_users = params[:suggested_users].split(',')
    suggested_user_ids = Array.new
    for suggested_user in suggested_users
      if !(mutual_friend_ids.include?(suggested_user.to_i)) and suggested_user.to_i != suggestee_id
        suggested_user_ids << suggested_user.to_i
      end
    end
    FriendSuggestion.add_friend_suggestions(suggestor.id, suggestee_id, suggested_user_ids) unless suggested_user_ids.blank?
    redirect_to :action => "show_profile"
  end

  def suggestions_advanced_search

    @user = current_user
    suggestion_ids = Friend.get_friend_suggestions(@user)

    includes = []

    condition_params = Array.new
    condition_sql = StringIO.new
    condition_params << condition_sql
    condition_sql << "users.id IN (?) AND "
    condition_params << suggestion_ids

    for key in params.keys
      if key.include?("|")
        type = key[0,key.index("|")]
        if type.eql?("emp")
          condition_sql << "employers.name = ? AND "
          condition_params << params[key]
          includes << :employers
        elsif type.eql?("univ")
          condition_sql << "universities.name = ? AND "
          condition_params << params[key]
          includes << :universities
        elsif type.eql?("mutual")
          name = params[key]
          first_name = name[0,name.index(" ")]
          last_name = name[name.index(" ")+1,name.size]
          condition_sql << "users.first_name = ? AND "
          condition_params << first_name
          condition_sql << "users.last_name = ? AND "
          condition_params << last_name
        elsif type.eql?("ht")
          condition_sql << "locations.name = ? AND "
          condition_params << params[key]
          includes << :hometown
        elsif type.eql?("cr")
          condition_sql << "locations.name = ? AND "
          condition_params << params[key]
          includes << :current_location
        end
      end
    end
    condition_str = condition_sql.string
    condition_str = condition_str[0,condition_str.size-5] unless condition_str.blank?
    condition_params[0] = condition_str

    @suggested_users = User.find(:all, :conditions => condition_params, :include => includes)
    set_sugg_checkboxes(User.find_by_ids(suggestion_ids))
    render :all_suggestions
  end
 

  #Viewing profile of some other person action
  def view_other_profile
    @curr_user = current_user
    @user = User.find_by_id(params[:id])
    if @curr_user.eql?(@user)
      redirect_to :action => "show_profile"
    end
    @friends = Friend.get_top_ten_friends(@user)
    ProfileVisit.add_update_visits(@user, @curr_user)
  end

  #Viewing all friends
  def friends
    @user = current_user
    @friends = @user.friends
  end

  #Viewing Friend Requests
  def requests
    @user = current_user
    @requests = Request.find_all_by_req_id(@user.id)
  end

  #Basic Search
  def search
    @user = current_user
    @search_results = User.get_search_results(params[:search],@user.id)
  end

  #Advanced Search Action
  def advanced_search
    @user = current_user
   
    @search_results = get_advanced_search_users(@user,params[:name], params[:hometown],
      params[:curr_location], params[:employer], params[:university])
    render :search
  end

  #Autocomplete suggestions for search
  def getsearchresults
    search_results = User.get_search_suggestions_autocomplete(params[:term],current_user.id)
    
    results = Array.new
    for search_result in search_results
      if !search_result.first_name.blank? and !search_result.last_name.blank?
        results << search_result.first_name + " " + search_result.last_name
      elsif search_result.first_name.blank?
        results << search_result.last_name
      elsif search_result.last_name.blank?
        results << search_result.first_name
      end
    end
    render :json => results.to_json
  end

  #Adding friend action from requests
  def add_friend
    user = User.find_by_id(params[:id])
    friendship = Friend.add_friend(current_user, user)
    Request.cancel_request(params[:id],current_user.id)
    Feed.create!(:user_id => user.id, :post_id => friendship.id, :feed_type => FEED_TYPE_FRIEND)
    UserMailer.add_friend(current_user.id, params[:id]).deliver

    redirect_to :action => :requests, :id => current_user.id
  end
  #Removing friend action
  def remove_friend
    user = User.find_by_id(params[:id])
    Friend.remove_friend(current_user, user)
    redirect_to :action => :view_other_profile, :id => params[:id]
  end

  #Adding friend request
  def add_friend_req
    
    Request.add_friend_req(current_user.id, params[:id])
    UserMailer.add_friend_req(current_user.id, params[:id]).deliver

    redirect_to :action => :view_other_profile, :id => params[:id]
  end
  #Cancel friend request
  def cancel_friend_req
    Request.cancel_request(params[:id],current_user.id)
    redirect_to :action => :requests,:id => current_user.id
  end

  #Advanced Search within friends
  def friends_advanced_search
    @user = current_user
    
    users = get_advanced_search_users(@user,params[:name], params[:hometown],
      params[:curr_location], params[:employer], params[:university])
    friend_user_ids = users.collect(&:id)
    @friends = Friend.get_friends_search_results(@user.id,friend_user_ids)
    
    render :friends
  end

  def get_advanced_search_users(user,name,hometown,curr_location,employer,university)

    includes = []
    condition_params = Array.new
    condition_sql = StringIO.new
    condition_params << condition_sql

    condition_sql << "users.id != ? AND "
    condition_params << user.id
    unless name.blank?
      condition_sql << "(users.first_name like ? or last_name like ? or email = ?) AND "
      condition_params << "%#{name}%"
      condition_params << "%#{name}%"
      condition_params << name
    end

    unless hometown.blank?
      condition_sql << "locations.name like ? AND "
      condition_params << "%#{hometown}%"
      includes << :hometown
    end
    unless curr_location.blank?
      condition_sql << "locations.name like ? AND "
      condition_params << "%#{curr_location}%"
      includes << :current_location
    end
    unless employer.blank?
      condition_sql << "employers.name like ? AND "
      condition_params << "%#{employer}%"
      includes << :employers
    end
    unless university.blank?
      condition_sql << "universities.name like ? AND "
      condition_params << "%#{university}%"
      includes << :universities
    end

    condition_str = condition_sql.string
    condition_str = condition_str[0,condition_str.size-5] unless condition_str.blank?
    condition_params[0] = condition_str

    users = User.find(:all, :conditions => condition_params, :include => includes)
    return users
  end

  def news_feed
    @user = current_user
    @friends = Friend.get_top_ten_friends(@user)
    friend_ids = @user.friends.collect(&:friend_id)
    user_ids = friend_ids + [@user.id]
    feeds = Feed.find_by_user_ids(user_ids)
    filtered_feed_ids = Unsubscription.filter_feeds(feeds,@user.id)
    @feeds = Feed.find_by_ids(filtered_feed_ids)
    
  end

  def top_news_feed
    @user = current_user
    @friends = Friend.get_top_ten_friends(@user)
    friend_ids = @user.friends.collect(&:friend_id)
    user_ids = friend_ids + [@user.id]
    feeds = Feed.find_by_user_ids(user_ids)
    filtered_feed_ids = Unsubscription.filter_feeds(feeds,@user.id)
    feeds = Feed.find_by_ids(filtered_feed_ids)
    @feeds = Feed.get_top_feeds_sorted(feeds,@user)
    render :action => "news_feed"
  end
  
  def unsubscribe_all
    @user = current_user
    unsubscribed_user_id = params[:user_id]
    Unsubscription.create!(:user_id => @user.id, :unsubscribed_user_id => unsubscribed_user_id, :feed_type => "all")
    render :json => "success".to_json
  end
  
  def unsubscribe_status
    @user = current_user
    unsubscribed_user_id = params[:user_id]
    Unsubscription.create!(:user_id => @user.id, :unsubscribed_user_id => unsubscribed_user_id, :feed_type => "status")
    render :json => "success".to_json
  end
  def unsubscribe_photo
    @user = current_user
    unsubscribed_user_id = params[:user_id]
    Unsubscription.create!(:user_id => @user.id, :unsubscribed_user_id => unsubscribed_user_id, :feed_type => "photo")
    render :json => "success".to_json
  end
  def unsubscribe_video
    @user = current_user
    unsubscribed_user_id = params[:user_id]
    Unsubscription.create!(:user_id => @user.id, :unsubscribed_user_id => unsubscribed_user_id, :feed_type => "video")
    render :json => "success".to_json
  end
  def subscribe_all
    @user = current_user
    subscribed_user_id = params[:user_id]
    unsubscription = Unsubscription.find_by_user_id_and_unsubscribed_user_id_and_feed_type(@user.id,subscribed_user_id,"all")
    unsubscription.destroy unless unsubscription.blank?
    render :json => "success".to_json
  end
  def subscribe_status
    @user = current_user
    subscribed_user_id = params[:user_id]
    unsubscription = Unsubscription.find_by_user_id_and_unsubscribed_user_id_and_feed_type(@user.id,subscribed_user_id,"status")
    unsubscription.destroy unless unsubscription.blank?
    render :json => "success".to_json
  end
  def subscribe_photo
    @user = current_user
    subscribed_user_id = params[:user_id]
    unsubscription = Unsubscription.find_by_user_id_and_unsubscribed_user_id_and_feed_type(@user.id,subscribed_user_id,"photo")
    unsubscription.destroy unless unsubscription.blank?
    render :json => "success".to_json
  end
  def subscribe_video
    @user = current_user
    subscribed_user_id = params[:user_id]
    unsubscription = Unsubscription.find_by_user_id_and_unsubscribed_user_id_and_feed_type(@user.id,subscribed_user_id,"video")
    unsubscription.destroy unless unsubscription.blank?
    render :json => "success".to_json
  end
  def wall
    @user = current_user
    if(defined? params[:id])
      @user = User.find_by_id(params[:id])
    end
    @id = current_user.id

    @posts = Post.find(:all,
      :conditions =>["user_id_for = ?",@user.id],
      :group => "caption",
      :order => "created_at DESC")

    @friends = Friend.get_top_ten_friends(@user)
    suggestion_ids = Friend.get_friend_suggestions(@user)
    @suggested_users = User.find_by_ids(suggestion_ids)
    users = User.find(:all, :select => "id,dob")
    @birthday_users = Array.new
    for user in users
      unless user.dob.blank?
        if user.dob.day.eql?(Time.now.day) and user.dob.month.eql?(Time.now.month)
          @birthday_users << User.find_by_id(user.id)
        end
      end
    end
  end



  def share
    @user = current_user
    postid = params[:id]
    @post = Post.find_by_id(postid)

    if @post.content_type.eql?("photo")
      @photo = Photo.find_by_id(@post.content_id)
    elsif @post.content_type.eql?("video")
      @video = Video.find_by_id(@post.content_id)
    end
  end

  def share_content
    @user = current_user
    postid = params[:post_id]
    @post = Post.find_by_id(postid)
    caption =  params[:caption]
    desc =params[:description]
    dateis = "#{params[:day]} #{params[:month]} #{params[:year]}"

    tagged_users = params[:friends].split(',')


    if @post.content_type.eql?("photo")
      @photo = Photo.find_by_id(@post.content_id)
      share = Share.create_share_post(postid,caption,desc,dateis,@user.id,tagged_users,"photo",@photo.id)
      add_tagged_users(tagged_users,@post.id,"share") unless tagged_users.blank?
    elsif @post.content_type.eql?("video")
      @video = Video.find_by_id(@post.content_id)
      share = Share.create_share_post(postid,caption,desc,dateis,@user.id,tagged_users,"video",@video.id)
      add_tagged_users(tagged_users,@post.id,"share") unless tagged_users.blank?
    elsif @post.content_type.eql?("status")
      share = Sharef.create_share_post(postid,caption,desc,dateis,@user.id,tagged_users,"status",nil)
      add_tagged_users(tagged_users,@post.id,"share") unless tagged_users.blank?
    end

    myshare = nil
    if !share.blank?
        myshare = share.id
    end
    Feed.create!(:user_id => @user.id,:post_id => myshare, :feed_type => FEED_TYPE_SHARE)
    flash[:error_msg] = "successfully shared!!"
    redirect_to :action  => "wall" , :id => @user.ids
  end

  def post_content

    @user = current_user
    @id = params[:id]
    text = params[:status]
    
    picture = params[:photo]
    video = params[:video]
    description = params[:description]
    dateis = "#{params[:day]} #{params[:month]} #{params[:year]}"

    tagged_users = params[:friends].split(',')

    post = Post.find_by_user_id_for_and_caption(@id,text)
    if(params[:places]!="")
      curr_location_param = params[:places].capitalize
      curr_location_db = Location.find_by_name(curr_location_param)
      unless curr_location_db.blank?
        curr_location = curr_location_db.id
      else
        curr_location = Location.create_new(curr_location_param)
        curr_location = curr_location.id
      end
    end

    if !(picture.blank?)

      
      # Set the column named "user_name" to @name
      if post.blank?
        album = Album.find_by_title_and_owner_id("Wall Photos", @user.id)
        Album.create_default_albums(@user) if album.blank?
        album = Album.find_by_title_and_owner_id("Wall Photos", @user.id)
        @upload = Photo.create!({:image => picture, :description =>description,:owner_id => @user.id, :date_taken => dateis})
        AlbumsPhoto.create!({:album_id => album.id, :photo_id => @upload.id})
        post= Post.create!({:content_type => "photo",:content_id =>@upload.id, :caption => text, :description =>description, :location_id =>curr_location, :user_id_for =>@id,:user_id =>@user.id,:date => dateis})
        Feed.create!(:user_id => @user.id, :post_id => post.id, :feed_type => FEED_TYPE_POST)
        add_tagged_users(tagged_users,post.id,"tagged") unless tagged_users.blank?
      end
     render(:partial => 'users/upload_photo.html', :locals => { :post_id => post.id ,:poster=> @user},:layout => false)
    elsif !(video.blank?)
      if post.blank?
        @video = Video.new({:source => video, :description =>description,:user_id => @user.id})
        if @video.save
          @video.convert
          flash[:notice] = "Video has been uploaded"
          post = Post.create!({:content_type => "video",:content_id =>@video.id, :caption => text, :description =>description, :location_id =>curr_location, :user_id =>@user.id, :user_id_for =>@id,:user_id_for => @id, :date => dateis})
          Feed.create!(:user_id => @user.id, :post_id => post.id, :feed_type => FEED_TYPE_POST)
          add_tagged_users(tagged_users,post.id,"tagged") unless tagged_users.blank?
        end
      end
      render(:partial => 'users/upload_video.html', :locals => { :post_id => post.id, :poster=> @user},:layout => false)
    else
      if post.blank?
        post = Post.create({:content_type => "status", :caption => text,:description =>description, :location_id =>curr_location, :user_id =>@user.id, :user_id_for =>@id, :date => dateis})
        Feed.create!(:user_id => @user.id, :post_id => post.id, :feed_type => FEED_TYPE_POST)
        add_tagged_users(tagged_users,post.id,"tagged") unless tagged_users.blank?
      end
      render(:partial => 'users/upload_status.html', :locals => { :post_id => post.id, :user_id=> @user.id},:layout => false)
    end
  end

  def add_tagged_users(tagged_users,post_id,notification_desc)
    
    tagged_user_ids = Array.new
    for tagged_user in tagged_users
      tagged_user_ids << tagged_user.to_i
    end
    PostsUser.add_tagged_users(post_id,tagged_user_ids)
    for tagged_user_id in tagged_user_ids

      unfollow_post = UnfollowedPost.find_by_user_id_and_post_id(tagged_user_id,post_id)
      if unfollow_post.blank?
        notification = Notification.find_notification(tagged_user_id,@post.id,notification_desc)
        Notification.create_notification(tagged_user_id,post_id,notification_desc) if notification.blank?
      end
    end
  end

  def like_content
    Like.create!(:post_id => params[:post_id], :like_user_id => params[:user_id])
    Feed.create!(:user_id => params[:user_id], :post_id => params[:post_id], :feed_type => FEED_TYPE_LIKE)
    num_likes = (Like.find_all_by_post_id(params[:post_id])).size
    render :json => num_likes.to_json
  end
  def unlike_content
    liked_post = Like.find_by_post_id_and_like_user_id(params[:post_id],params[:user_id])
    liked_post.destroy unless liked_post.blank?
    feed = Feed.find_by_user_id_and_post_id_and_feed_type(params[:user_id],params[:post_id],FEED_TYPE_LIKE)
    feed.destroy unless feed.blank?
    num_likes = (Like.find_all_by_post_id(params[:post_id])).size
    render :json => num_likes.to_json
  end

  def like_comment
    CommentLike.create!(:comment_id => params[:comment_id], :like_user_id => params[:user_id])
    num_likes = (CommentLike.find_all_by_comment_id(params[:comment_id])).size
    render :json => num_likes.to_json
  end
  def unlike_comment
    liked_post = CommentLike.find_by_comment_id_and_like_user_id(params[:comment_id],params[:user_id])
    liked_post.destroy unless liked_post.blank?
    num_likes = (CommentLike.find_all_by_comment_id(params[:comment_id])).size
    render :json => num_likes.to_json
  end
  def add_comment
    @user = current_user
    Comment.create!(:post_id => params[:post_id],:commentee_user_id => @user.id, :description => params[:comment])
    Feed.create!(:user_id => @user.id, :post_id => params[:post_id], :feed_type => FEED_TYPE_COMMENT)
    render :json => "#{@user.first_name} #{@user.last_name}".to_json
  end
  def unfollow_content
    UnfollowedPost.create!(:post_id => params[:post_id], :user_id => params[:user_id])
    render :json => "success".to_json
  end
  def follow_content
    unfollowed_post = UnfollowedPost.find_by_post_id_and_user_id(params[:post_id],params[:user_id])
    unfollowed_post.destroy unless unfollowed_post.blank?
    render :json => "success".to_json
  end
  def ticker_feed

    @user = current_user
    type = params[:type]

    puts '#########################################'
    puts type

    friend_ids = @user.friends.collect(&:friend_id)
    user_ids = friend_ids + [@user.id]

    if(type=="poll")
    @feeds = Feed.find(:all,
      :conditions =>['TIMESTAMPDIFF(SECOND,updated_at,?)<5',DateTime.now.utc],
      :order => "updated_at DESC")
    else
    #@feeds = Feed.where('TIMESTAMPDIFF(DAY,updated_at,?)<2',DateTime.now.utc)
    @feeds = Feed.find(:all,
      :conditions =>['TIMESTAMPDIFF(DAY,updated_at,?)<2',DateTime.now.utc],
      :order => "updated_at DESC")
    end
    
    render(:partial => 'users/feed_ticker.html',:locals => {:feeds => @feeds}, :layout => false)
  end

  def ticker_post_detail
    
    post = Post.find_by_id(params[:post_id])
    user = User.find_by_id(post.user_id)
           if post.content_type.eql?("photo")  
              render(:partial => 'users/upload_photo.html', :locals => {:post_id =>post.id},:layout => false) 
            elsif post.content_type.eql?("video")
             render(:partial => 'users/upload_video.html', :locals => {:post_id => post.id},:layout => false)
            else
             render(:partial => 'users/upload_status.html', :locals => { :post_id => post.id, :user_id =>user.id},:layout => false)
           end
  end



  def friendship
    @user = current_user
    friend_id = params[:id]
    @friend = User.find_by_id(friend_id)
    
    photos_user_ids = PhotosUser.find_all_by_user_id(@user.id).collect(&:photo_id)
    photos_friend_ids = PhotosUser.find_all_by_user_id(friend_id).collect(&:photo_id)
    @commonly_tag_photos = Photo.find_by_ids((photos_user_ids & photos_friend_ids))

    employers_user = UsersEmployer.find_all_by_user_id(@user.id).collect(&:employer_id)
    employers_friend = UsersEmployer.find_all_by_user_id(friend_id).collect(&:employer_id)
    @common_employer = Employer.find_by_ids((employers_user & employers_friend))
    
    univ_user = UsersUniversity.find_all_by_user_id(@user.id).collect(&:university_id)
    univ_friend = UsersUniversity.find_all_by_user_id(friend_id).collect(&:university_id)
    @common_university = University.find_by_ids((univ_user & univ_friend))

    #@commented = Comment.get_commented_on_others_post(@user, @friend)
    @mutual_friends = User.find_by_ids(Friend.mutual_friend_ids(@user, @friend))
  end


  # GET /users/1/edit
  def edit
    @user = current_user
    render :layout => 'edit_profile'
    #redirect_to :action  => "show_profile", :id => @user.id
  end

  def photo
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(update, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(edit_user_path, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_photo
    @user = current_user
    @photo = params[:image]
    @user.update_attributes(:photo => @photo)

    if !@photo.blank?
      @album = Album.find_by_title_and_owner_id("Profile Picture", @user.id)
      
      Album.create_default_albums(@user) if @album.blank?
        
      @album = Album.find_by_title_and_owner_id("Profile Picture", @user.id)
      
      @photo = Photo.create({:image => @photo,:owner_id => @user.id})
      AlbumsPhoto.create({:album_id => @album.id, :photo_id => @photo.id})
    end
    redirect_to :action => "edit"
  end

  def terms
    @user = User.find_by_id(params[:id])
  end
 
  def lists
    @user = User.find_by_id(params[:id])
  end
  
  def show_list
    @user = current_user
    @list = List.find_by_id(params[:id])
    @list_id = UsersList.find_by_user_id_and_list_id(@user.id ,@list.id)
    friend_ids = UsersListsFriend.find_by_user_list_id(@list_id).collect(&:friend_id)
    @friends = User.find_by_ids(friend_ids)
  end

  def like_user
    @user = current_user
    @post = Post.find_by_id(params[:id])
    like_ids = Like.find_all_by_post_id(@post.id)
    @users = User.find_by_ids(like_ids.collect(&:like_user_id)) unless like_ids.blank?
    
  end
  def comment_like_user
    @user = current_user
    like_ids = CommentLike.find_all_by_comment_id(params[:id])
    @users = User.find_by_ids(like_ids.collect(&:like_user_id)) unless like_ids.blank?
    render :action => "like_user"
  end

  def  notifications
    @user = current_user
    @notifications = Notification.find_all_by_user_id(@user.id)
  end

  
end
  
  
