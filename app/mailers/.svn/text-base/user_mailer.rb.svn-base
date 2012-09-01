class UserMailer < ActionMailer::Base
  default :from => "from@example.com"


  def add_friend(user_id,friend_id)

  @user =  User.find(:first,
        :conditions => ["id = ?",user_id])
  @friend =  User.find(:first,
        :conditions => ["id = ?",friend_id])
    
   mail(:to => @friend.email, :subject => "Friend request accepted")
  end


   def add_friend_req(user_id,friend_id)

  @user =  User.find(:first,
        :conditions => ["id = ?",user_id])
  @friend =  User.find(:first,
        :conditions => ["id = ?",friend_id])

   mail(:to => @friend.email, :subject => "New Friend request recieved")
  end


end
