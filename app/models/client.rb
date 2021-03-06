class Client < ApplicationRecord
  belongs_to :branch
  belongs_to :discount
  belongs_to :parent
  has_many :paid_services
  has_many :visited_days
  accepts_nested_attributes_for :parent
  
  scope :find_client, -> (name) {where("name LIKE '%#{name.mb_chars.capitalize.to_s}%'")}
  
  def handle_visit
    unless self.visited_today?
      self.visited_days.create(:day => Date.today)
      self.paid_services.countable.each do |item|
        item.update_rest_paid_days
      end
    end
  end
  
  def visited_today?
    self.visited_days.find_by(:day => Date.today)
  end
  
  def discount_client?
    self.discount
  end
  
  def has_active_paid_service?(service_id)
    self.paid_services.find_by(:service_id => service_id,:status => true)
  end
end
