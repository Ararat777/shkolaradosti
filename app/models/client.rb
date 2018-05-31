class Client < ApplicationRecord
  belongs_to :branch
  belongs_to :discount
  belongs_to :parent
  has_many :paid_services
  has_many :visited_days
  has_many :foods
  accepts_nested_attributes_for :parent
  
  def has_active_paid_service?(service_id)
    self.paid_services.find_by(:service_id => service_id,:status => true)
  end
end
