class PaidService < ApplicationRecord
  belongs_to :client
  belongs_to :service
  
  def check_status
    
    if self.status && self.end_date < Date.today
      self.update(:status => false)
      self.status
    end
    
    self.status
    
  end
end
