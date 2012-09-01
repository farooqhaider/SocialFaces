class Feed < ActiveRecord::Base

  belongs_to :user
  belongs_to :post

  def self.find_by_user_ids(user_ids)
    feeds = Feed.find(:all, :conditions => ["user_id IN (?)",user_ids])
    return feeds
  end
  def self.find_by_ids(ids)
    feeds = Feed.find(:all, :conditions => ["id IN (?)",ids],:order => "created_at DESC")
    return feeds
  end
  
  def self.get_top_feeds_sorted(feeds,curr_user)

    friend_ids = curr_user.friends.collect(&:friend_id)
    friends_sorted = Friend.get_suggestee_friends_score(curr_user.id)
    top_friend_ids = Array.new
    unless friends_sorted.blank?
      i = 0
      while (i < friends_sorted.size and i < NUM_TOP_FRIENDS)
        top_friend_ids << friends_sorted[i][0]
        i += 1
      end
    end
    other_friend_ids = friend_ids - top_friend_ids
    sorted_feeds = Array.new
    feeds_score = {}
    for feed in feeds
      if feed.feed_type.eql?(FEED_TYPE_FRIEND)
        feeds_score[feed.id] = DEFAULT_SCORE_ADDED_FRIEND
      else
        if feed.feed_type.eql?(FEED_TYPE_SHARE)
          share = Share.find_by_id(feed.post_id)
          post_id = share.post_id
        else
          post_id = feed.post_id
        end
        puts "post_id: #{post_id}"
        top_friends_comments = Feed.get_friends_commented_count(post_id,top_friend_ids)
        other_friends_comments = Feed.get_friends_commented_count(post_id,other_friend_ids)
        comments_score = ((top_friends_comments * WEIGHTAGE_TOP_FRIEND_ACTIVITY)
          + other_friends_comments) * WEIGHTAGE_COMMENTS
        puts "COMMENTS_SCORE: #{comments_score}"
        top_friends_likes = Feed.get_friends_likes_count(post_id,top_friend_ids)
        other_friends_likes = Feed.get_friends_likes_count(post_id,other_friend_ids)
        likes_score = ((top_friends_likes * WEIGHTAGE_TOP_FRIEND_ACTIVITY)
          + other_friends_likes) * WEIGHTAGE_LIKES
        puts "LIKES_SCORE: #{likes_score}"
        top_friends_tagged = Feed.get_friends_tagged_count(post_id,top_friend_ids)
        other_friends_tagged = Feed.get_friends_tagged_count(post_id,other_friend_ids)
        tagging_score = ((top_friends_tagged * WEIGHTAGE_TOP_FRIEND_ACTIVITY)
          + other_friends_tagged) * WEIGHTAGE_TAGS
        feeds_score[feed.id] = comments_score + likes_score + tagging_score
      end    
    end
    feed_ids_sorted = (feeds_score.sort_by {|k,v| v}).reverse
    i = 0
    while (i < feed_ids_sorted.size)
      feed_id = feed_ids_sorted[i][0]
      sorted_feeds << Feed.find_by_id(feed_id)
      i += 1
    end
    return sorted_feeds
  end

  def self.get_friends_commented_count(post_id,friend_ids)
    comments = Comment.find(:all,
    :conditions => ["post_id = ? and commentee_user_id IN (?)",post_id,friend_ids])
    return comments.size
  end
  def self.get_friends_likes_count(post_id,friend_ids)
    likes = Like.find(:all,
    :conditions => ["post_id = ? and like_user_id IN (?)",post_id,friend_ids])
    return likes.size
  end
  def self.get_friends_tagged_count(post_id,friend_ids)
    tagged_friends = PostsUser.find(:all,
    :conditions => ["post_id = ? and user_id IN (?)",post_id,friend_ids])
    return tagged_friends.size
  end
end
