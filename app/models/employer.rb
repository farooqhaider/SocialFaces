class Employer < ActiveRecord::Base
  has_many :users_employers
  has_many :users, :through => :users_employers

  def self.find_by_ids(emp_ids)
    employers = Employer.find(:all, :conditions => ["id IN (?)",emp_ids])
    return employers
  end
end
