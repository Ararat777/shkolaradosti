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
end
