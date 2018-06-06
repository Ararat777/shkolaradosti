class Month < ApplicationRecord
  has_many :exceptional_days
  before_create :set_work_days
  
  private
  
  def set_work_days
    current_year = self.year
    month = Date.new(current_year,self.number)
    work_days = (month..month.end_of_month).select{|x| x.strftime("%a") != "Sat" && x.strftime("%a") != "Sun" }.size
    self.work_days_size = work_days
  end
end
