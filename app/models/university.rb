class University < ActiveRecord::Base
  has_many :users_universities
  has_many :users, :through => :users_universities

  def self.find_by_ids(univ_ids)
    universities = University.find(:all, :conditions => ["id IN (?)",univ_ids])
    return universities
  end
end
