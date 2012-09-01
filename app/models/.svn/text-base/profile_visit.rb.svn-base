class ProfileVisit < ActiveRecord::Base

  def self.add_update_visits(user, visitor)
    profile_visit = ProfileVisit.find_by_user_id_and_visitor_id(user.id,visitor.id)
    if profile_visit.blank?
      ProfileVisit.create!(:user_id => user.id, :visitor_id => visitor.id, :count => 1)
    else
      profile_visit.count = profile_visit.count + 1
    end
  end

  def self.get_profile_visit_count(user,visitor)
    profile_visit = ProfileVisit.find_by_user_id_and_visitor_id(user.id,visitor.id)
    unless profile_visit.blank?
      return profile_visit.count
    else
      return 0;
    end
  end
end
