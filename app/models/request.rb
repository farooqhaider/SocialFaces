class Request < ActiveRecord::Base

  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :req_user, :class_name => "User", :foreign_key => "req_id"

  def self.is_pending_req?(user_id, req_id)
    request = Request.find_by_user_id_and_req_id(user_id,req_id)
    return (request.blank?)? false : true
  end

  def self.add_friend_req(user_id, req_id)
    Request.create!(:user_id => user_id, :req_id => req_id)
  end
  
  def self.cancel_request(user_id, req_id)
    request = Request.find_by_user_id_and_req_id(user_id,req_id)
    request.destroy
  end
end