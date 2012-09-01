class Share < ActiveRecord::Base

  def self.create_share_post(post_id,caption,description,dateis,user_id,tagged_users,content_type,content_id)
    for tagged_user in tagged_users
      desc = "shared "+content_type
      share = Share.create!(:post_id=> post_id,:caption=>caption,:description =>description,:date=>dateis,:shared_by_id =>user_id, :shared_with_id =>tagged_user.to_i)
      Post.create!(:content_type => content_type,:content_id =>content_id, :caption =>caption, :description =>desc, :user_id_for =>tagged_user.to_i,:user_id =>user_id,:date => dateis)
     
    end
    return share
  end
  
end
