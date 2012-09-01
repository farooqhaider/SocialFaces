class Notification < ActiveRecord::Base

  def self.create_notification(user_id,post_id,description)
    Notification.create!(:user_id => user_id, :post_id => post_id,:description => description)
  end
  
  def self.find_notification(user_id,post_id,description)
    notification = Notification.find(:first,
      :conditions => ["user_id = ? and post_id = ? and description = ?",user_id,post_id,description])
    return notification

  end
end
