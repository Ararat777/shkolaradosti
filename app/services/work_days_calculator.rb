class WorkDaysCalculator
  
  def initialize(start_date,end_date)
    @start_date = start_date
    @end_date = end_date
  end
  
  def call
    calculated_work_days = (@start_date..@end_date).select{|x| x.strftime("%a") != "Sat" && x.strftime("%a") != "Sun" }.size
    calculated_work_days += ExceptionalDay.where(:is_holiday => false,:day => @start_date..@end_date).size
    calculated_work_days -= ExceptionalDay.where(:is_holiday => true,:day => @start_date..@end_date).size
  end
  
end