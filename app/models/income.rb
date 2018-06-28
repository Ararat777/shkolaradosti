class Income < ApplicationRecord
  include Reportable
  belongs_to :cash_box
  after_create :exec_income
  before_create :set_title
  
  scope :cash_box, -> (cash_box) {where cash_box_id: cash_box}
  scope :client, -> (client) {where client_id: client}
  scope :service, -> (service) {where service_id: service == "nil" ? nil : service}
  scope :start_date, -> (start_date) {where("created_at >= ?", start_date)}
  scope :end_date, -> (end_date) {where("created_at <= ?", end_date)}
  
  def client
    if self.client_id
      Client.find(self.client_id)
    end
  end
  
  def service
    if self.service_id
      Service.find(self.service_id)
    end
  end
  
  private
  
  def exec_income
    self.cash_box.increase_cash_box_amount(self.amount)
  end
  
  def set_title
    if self.service
      self.title = Service.find(self.service_id).title
    end
  end
end
