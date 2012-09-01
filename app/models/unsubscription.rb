class Unsubscription < ActiveRecord::Base

  def self.filter_feeds(feeds,curr_user_id)
    filtered_feed_ids = feeds.collect(&:id)
    for feed in feeds
      if feed.feed_type.eql?(FEED_TYPE_POST)
        post = Post.find_by_id(feed.post_id)
        filtered_feed_ids.delete(feed.id) if Unsubscription.filter_feed_post?(curr_user_id,post.content_type,[post.user_id,post.user_id_for])
      elsif feed.feed_type.eql?(FEED_TYPE_LIKE)
        post = Post.find_by_id(feed.post_id)
        filtered_feed_ids.delete(feed.id) if Unsubscription.filter_feed_post?(curr_user_id,post.content_type,[feed.user_id])
      elsif feed.feed_type.eql?(FEED_TYPE_SHARE)
        share = Share.find_by_id(feed.post_id)
        post = Post.find_by_id(share.post_id)
        filtered_feed_ids.delete(feed.id) if Unsubscription.filter_feed_post?(curr_user_id,post.content_type,[feed.user_id])
      elsif feed.feed_type.eql?(FEED_TYPE_TAG)
        post_user = PostsUser.find_by_id(feed.post_id)
        post = Post.find_by_id(post_user.post_id)
        filtered_feed_ids.delete(feed.id) if Unsubscription.filter_feed_post?(curr_user_id,post.content_type,[feed.user_id])
      elsif feed.feed_type.eql?(FEED_TYPE_FRIEND)
        friendship = Friend.find_by_id(feed.post_id)
        filtered_feed_ids.delete(feed.id) if Unsubscription.unsubscription_found?(curr_user_id,[friendship.user_id,friendship.friend_id],"all") 
      end
    end
    return filtered_feed_ids
  end
  
  def self.filter_feed_post?(curr_user_id,content_type,unsubscribed_ids)
    if Unsubscription.unsubscription_found?(curr_user_id, unsubscribed_ids, "all")
      return true
    elsif Unsubscription.unsubscription_found?(curr_user_id, unsubscribed_ids, content_type)
      return true
    else
      return false
    end
  end

  def self.unsubscription_found?(curr_user_id,unsubscribed_ids,content_type)
    unsubscription = Unsubscription.find(:first,
      :conditions => ["user_id = ? and unsubscribed_user_id IN (?) and feed_type = ?",
        curr_user_id,unsubscribed_ids,content_type])
    if unsubscription.blank?
      return false
    else
      return true
    end
  end
end
