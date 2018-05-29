class Client < ApplicationRecord
  belongs_to :branch
  belongs_to :discount
  has_many :paid_services
  has_many :visited_days
  has_many :foods
  
  
  def has_active_paid_service?(service_id)
    if paid_service = self.paid_services.find_by(:service_id => service_id,:status => true)
      return paid_service
    end
    
    false
    
  end
end
