class PaidService < ApplicationRecord
  belongs_to :client
  belongs_to :service
  before_save :check_lack
  
  def check_status
    
    if self.status && self.end_date < Date.today
      self.update(:status => false)
      self.status
    end
    
    self.status
    
  end
  
  def check_lack
    if self.required_amount != self.amount
      self.lack = self.required_amount - self.amount
    else
      self.lack = 0
    end
  end
  
  def calculate_required_amount(service_id,start_date,end_date)
    service = Service.find(service_id)
    calculated_work_days = (start_date..end_date).select{|x| x.strftime("%a") != "Sat" && x.strftime("%a") != "Sun" }.size
    calculated_work_days += ExceptionalDay.where(:is_holiday => false,:day => start_date..end_date).size
    calculated_work_days -= ExceptionalDay.where(:is_holiday => true,:day => start_date..end_date).size
    month_work_days = Month.find_by(:year => start_date.year,:number => start_date.month).work_days_size
    self.required_amount = ((service.price / month_work_days) * calculated_work_days).round
  end
end
