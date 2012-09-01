class UsersBook < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :book
#Function that updates books liked by users according to books edited by user
  def self.add_user_books(user_id, book_ids)
    for book_id in book_ids
      user_book = UsersBook.find(:first,
        :conditions => ["user_id = ? and book_id = ?",user_id, book_id])
      if user_book.blank?
        UsersBook.create!(:user_id => user_id, :book_id => book_id)
      end
    end
    user_book_ids = UsersBook.find(:all, :conditions => ["user_id = ?",user_id]).collect(&:book_id)
    
    for user_book_id in user_book_ids
      unless book_ids.include?(user_book_id)
        user_book = UsersBook.find(:first,
          :conditions => ["user_id = ? and book_id = ?",user_id,user_book_id])
        user_book.destroy
      end

    end
  end

  def self.get_common_books_count(user_id_1, user_id_2)
    books_user1 = UsersBook.find_all_by_user_id(user_id_1).collect(&:book_id)
    books_user2 = UsersBook.find_all_by_user_id(user_id_2).collect(&:book_id)
    common_books_ids = books_user1 & books_user2
    return common_books_ids.size
  end
end
