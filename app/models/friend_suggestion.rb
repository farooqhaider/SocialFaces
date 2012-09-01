class FriendSuggestion < ActiveRecord::Base

  def self.add_friend_suggestions(suggestor_id, suggestee_id, suggested_users_ids)
    for suggested_user_id in suggested_users_ids
      suggestion = FriendSuggestion.find(:all,
        :conditions => ["suggestor_user_id = ? AND suggestee_user_id = ? AND suggested_user_id = ?",suggestor_id, suggestee_id, suggested_user_id])
      if suggestion.blank?
        FriendSuggestion.create!(:suggestor_user_id => suggestor_id, :suggestee_user_id => suggestee_id,
        :suggested_user_id => suggested_user_id)
      end
    end
  end
end
