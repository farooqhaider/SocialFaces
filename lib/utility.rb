#Useful functions that can be reused in our project
class Utility

  #Returns number of month according to month name
  def self.conv_month_to_num(month)
    if month.eql?("January")
      return 1
    elsif month.eql?("February")
      return 2
    elsif month.eql?("March")
      return 3
    elsif month.eql?("April")
      return 4
    elsif month.eql?("May")
      return 5
    elsif month.eql?("June")
      return 6
    elsif month.eql?("July")
      return 7
    elsif month.eql?("August")
      return 8
    elsif month.eql?("September")
      return 9
    elsif month.eql?("October")
      return 10
    elsif month.eql?("November")
      return 11
    elsif month.eql?("December")
      return 12
    end
  end
  
end
