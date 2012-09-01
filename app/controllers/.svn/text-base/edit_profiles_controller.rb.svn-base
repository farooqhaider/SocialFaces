require 'utility'
class EditProfilesController < ApplicationController
  layout 'edit_profile'
   before_filter :authenticate_user!

  #edit basic information
  def basic_info

    @user = current_user
    @user_languages = @user.languages.map(&:attributes).to_json unless @user.languages.blank?
  end

  #basic information successfully update action
  def basic_info_success

    @user = current_user
    @user_languages = @user.languages.map(&:attributes).to_json unless @user.languages.blank?
  end

  #updating basic information
  def update_basic_info
    @@logger.info "In update basic information function"
    #user = User.find_by_id(session[:user_id])
    user = current_user
    hometown_param = params[:hometown].capitalize
    hometown_db = Location.find_by_name(hometown_param)
    unless hometown_db.blank?
      hometown = hometown_db.id
    else
      hometown = Location.create_new(hometown_param)
      hometown = hometown.id
    end
    user.hometown_id = hometown
    curr_location_param = params[:curr_location].capitalize
    curr_location_db = Location.find_by_name(curr_location_param)
    unless curr_location_db.blank?
      curr_location = curr_location_db.id
    else
      curr_location = Location.create_new(curr_location_param)
      curr_location = curr_location.id
    end
    user.current_location_id = curr_location

    user.gender = params[:gender]
    if params[:show_gender].eql?("show_gender")
      show_gender = 1
    elsif params[:show_gender].blank?
      show_gender = 0
    end
    user.show_gender = show_gender
    bd_str = "#{params[:bd_day]}/#{Utility.conv_month_to_num(params[:bd_month])}/#{params[:bd_year]}"
    birthdate = Date.strptime(bd_str, "%d/%m/%Y")
    user.dob = birthdate
    show_bd = params[:show_bd]
    if show_bd.eql?("Show my full date of birth in my profile")
      show_bd = "full"
    elsif show_bd.eql?("Show only day and month in my profile")
      show_bd = "dayandmonth"
    else
      show_bd = "dontshow"
    end
    user.show_bd = show_bd
    if params[:interested_women].eql?("interested_women") and params[:interested_men].eql?("interested_men")
      interested_in = "both"
    elsif params[:interested_women].eql?("interested_women")
      interested_in = "women"
    elsif params[:interested_men].eql?("interested_men")
      interested_in = "men"
    else
      interested_in = "none"
    end
    user.interested_in = interested_in
    languages = params[:languages].split(',')
    language_ids = Array.new
    for language in languages
      language_ids << language.to_i
    end
    @@logger.debug "Adding Language IDS: #{language_ids.inspect}"
    UsersLanguage.add_user_languages(user.id, language_ids)

    about_me = params[:about_me]
    user.about_me = about_me
    user.save!

    redirect_to :action => :basic_info_success
  end

  #Languages that are suggested in autocomplete
  def getlanguages
    languages = Language.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => languages.map(&:attributes).to_json
  end
  #Musics that are suggested in autocomplete
  def getmusics
    musics = Music.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => musics.map(&:attributes).to_json
  end
  #Books that are suggested in autocomplete
  def getbooks
    books = Book.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => books.map(&:attributes).to_json
  end
  #Movies that are suggested in autocomplete
  def getmovies
    movies = Movie.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => movies.map(&:attributes).to_json
  end
  #Tv Shows that are suggested in autocomplete
  def gettvshows
    tv_shows = TvShow.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => tv_shows.map(&:attributes).to_json
  end
  #Games that are suggested in autocomplete
  def getgames
    games = Game.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => games.map(&:attributes).to_json
  end

  #Employers that are suggested in autocomplete
  def getemployers
    employers = Employer.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => employers.map(&:attributes).to_json
  end
  #Universities that are suggested in autocomplete
  def getuniversities
    universities = University.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => universities.map(&:attributes).to_json
  end
  #Schools that are suggested in autocomplete
  def getschools
    schools = School.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => schools.map(&:attributes).to_json
  end
  #Activities that are suggested in autocomplete
  def getactivities
    activities = Activity.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => activities.map(&:attributes).to_json
  end
  #Interests that are suggested in autocomplete
  def getinterests
    interests = Interest.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => interests.map(&:attributes).to_json
  end

  #Sports that are suggested in autocomplete
  def getsports
    sports = Sport.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => sports.map(&:attributes).to_json
  end
  #Teams that are suggested in autocomplete
  def getteams
    teams = Team.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => teams.map(&:attributes).to_json
  end
  #Books that are suggested in autocomplete
  def getathletes
    athletes = Athlete.find(:all, :conditions => ["name like ?","%#{params[:q]}%"])
    render :json => athletes.map(&:attributes).to_json
  end
  #Edit Friends Family Info
  def friends_family
      @user = current_user

  end

  #Updating Friends Family Info.
  def update_friends_family
    #user = User.find_by_id(session[:user_id])
    @@logger.info "In update friends family function"
    user = current_user
    user.relationship_status = params[:relationship_status]
    user.save!
    #send email code on email address
    @@logger.info "Friends Family info Updated"
    redirect_to :action => :friends_family_success
  end

  #friends family successfully update action
  def friends_family_success
    @user = current_user
  end

  #Edit Education Work Info
  def education_work

    @user = current_user
    @user_employers = @user.employers.map(&:attributes).to_json unless @user.employers.blank?
    @user_universities = @user.universities.map(&:attributes).to_json unless @user.universities.blank?
    @user_schools = @user.schools.map(&:attributes).to_json unless @user.schools.blank?
  end

#Updating Education Work Info
  def update_education_work
    #user = User.find_by_id(session[:user_id])
    @@logger.info "In update education work function"
    user = current_user
    employers = params[:employers].split(',')
    employer_ids = Array.new
    for employer in employers
      employer_ids << employer.to_i
    end
    @@logger.debug "Adding employer IDS: #{employer_ids.inspect}"
    UsersEmployer.add_user_employers(user.id, employer_ids)

    universities = params[:universities].split(',')
    university_ids = Array.new
    for university in universities
      university_ids << university.to_i
    end
    @@logger.debug "Adding university IDS: #{university_ids.inspect}"
    UsersUniversity.add_user_universities(user.id, university_ids)

    schools = params[:schools].split(',')
    school_ids = Array.new
    for school in schools
      school_ids << school.to_i
    end
    @@logger.debug "Adding school IDS: #{school_ids.inspect}"
    UsersSchool.add_user_schools(user.id, school_ids)
    @@logger.info "Education work info updated"
    redirect_to :action => :education_work_success
  end

  #education work information successfully update action
  def education_work_success
  @user = current_user
    @user_employers = @user.employers.map(&:attributes).to_json unless @user.employers.blank?
    @user_universities = @user.universities.map(&:attributes).to_json unless @user.universities.blank?
    @user_schools = @user.schools.map(&:attributes).to_json unless @user.schools.blank?
  end

  #Edit arts entertainment info
  def arts_entertainment
       @user = current_user
    @user_musics = @user.musics.map(&:attributes).to_json unless @user.musics.blank?
    @user_movies = @user.movies.map(&:attributes).to_json unless @user.movies.blank?
    @user_books = @user.books.map(&:attributes).to_json unless @user.books.blank?
    @user_tv_shows = @user.tv_shows.map(&:attributes).to_json unless @user.tv_shows.blank?
    @user_games = @user.games.map(&:attributes).to_json unless @user.games.blank?

  end

  #Updating Arts Entertainment Info
  def update_arts_entertainment
    #user = User.find_by_id(session[:user_id])
    user = current_user
    musics = params[:musics].split(',')
    music_ids = Array.new
    for music in musics
      music_ids << music.to_i
    end
    UsersMusic.add_user_musics(user.id, music_ids)

    books = params[:books].split(',')
    book_ids = Array.new
    for book in books
      book_ids << book.to_i
    end
    UsersBook.add_user_books(user.id, book_ids)

    movies = params[:movies].split(',')
    movie_ids = Array.new
    for movie in movies
      movie_ids << movie.to_i
    end
    UsersMovie.add_user_movies(user.id, movie_ids)

    tv_shows = params[:television].split(',')
    tv_show_ids = Array.new
    for tv_show in tv_shows
      tv_show_ids << tv_show.to_i
    end
    UsersTvShow.add_user_tv_shows(user.id, tv_show_ids)

    games = params[:games].split(',')
    game_ids = Array.new
    for game in games
      game_ids << game.to_i
    end
    UsersGame.add_user_games(user.id, game_ids)

    redirect_to :action => :arts_entertainment_success
  end
  #arts entertainment information successfully update action
  def arts_entertainment_success
    @user = current_user
    @user_musics = @user.musics.map(&:attributes).to_json unless @user.musics.blank?
    @user_movies = @user.movies.map(&:attributes).to_json unless @user.movies.blank?
    @user_books = @user.books.map(&:attributes).to_json unless @user.books.blank?
    @user_tv_shows = @user.tv_shows.map(&:attributes).to_json unless @user.tv_shows.blank?
    @user_games = @user.games.map(&:attributes).to_json unless @user.games.blank?
  end

  #Editing Sports Info
  def sport
    @user = current_user
    @user_sports = @user.sports.map(&:attributes).to_json unless @user.sports.blank?
    @user_teams = @user.teams.map(&:attributes).to_json unless @user.teams.blank?
    @user_athletes = @user.athletes.map(&:attributes).to_json unless @user.athletes.blank?
  end

  #Updating Sports Info
  def update_sports
    #user = User.find_by_id(session[:user_id])
    user = current_user
    sports = params[:sports].split(',')
    sport_ids = Array.new
    for sport in sports
      sport_ids << sport.to_i
    end
    UsersSport.add_user_sports(user.id, sport_ids)

    teams = params[:teams].split(',')
    team_ids = Array.new
    for team in teams
      team_ids << team.to_i
    end
    UsersTeam.add_user_teams(user.id, team_ids)

    athletes = params[:athletes].split(',')
    athlete_ids = Array.new
    for athlete in athletes
      athlete_ids << athlete.to_i
    end
    UsersAthlete.add_user_athletes(user.id, athlete_ids)

    redirect_to :action => :sport_success
  end

  #Sports information successfully update action
  def sport_success
    @user = current_user
    @user_sports = @user.sports.map(&:attributes).to_json unless @user.sports.blank?
    @user_teams = @user.teams.map(&:attributes).to_json unless @user.teams.blank?
    @user_athletes = @user.athletes.map(&:attributes).to_json unless @user.athletes.blank?
  end

  #Editing Activities Interests Info
  def activities_interests
     @user = current_user
     @user_activities = @user.activities.map(&:attributes).to_json unless @user.activities.blank?
    @user_interests = @user.interests.map(&:attributes).to_json unless @user.interests.blank?
  end
  #Activities Interests Info successfully update action
  def activities_interests_success
     @user = current_user
     @user_activities = @user.activities.map(&:attributes).to_json unless @user.activities.blank?
    @user_interests = @user.interests.map(&:attributes).to_json unless @user.interests.blank?
  end
  #Updating Activities Interests Info
  def update_activities

    #user = User.find_by_id(session[:user_id])
    user = current_user
    activities = params[:activities].split(',')
    activity_ids = Array.new
    for activity in activities
      activity_ids << activity.to_i
    end
    UsersActivity.add_user_activities(user.id, activity_ids)

    interests = params[:interests].split(',')
    interest_ids = Array.new
    for interest in interests
      interest_ids << interest.to_i
    end
    UsersInterest.add_user_interests(user.id, interest_ids)
    redirect_to :action => :activities_interests_success
  end

  #Editing Contact Info
  def contact_info
     @user = current_user
  end

  #Updating Contact Info
  def update_contact_info
    #user = User.find_by_id(session[:user_id])
    user = current_user
    user.address = params[:address]
    user.address_towncity = params[:city]
    user.adress_zipcode = params[:zip]
    user.address_neighbourhood = params[:neighbourhood]
    user.website = params[:website]
    user.save!
    redirect_to :action => :contact_info_success
  end

  #Contact info successfully update action
  def contact_info_success
    @user = current_user
  end
end
