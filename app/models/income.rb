class Income < ApplicationRecord
  include Pdfable
  include Calculable
  belongs_to :cash_box_session
  belongs_to :paid_service
  after_create :check_paid_service_lack,if: :has_paid_service?
  before_create :set_income_credentials,if: :has_paid_service?
  
  scope :cash_box_filter, -> (cash_box) {joins(:cash_box_session).where(cash_box_sessions: {cash_box_id: cash_box}) }
  scope :client_filter, -> (client) {where client_id: client}
  scope :service_filter, -> (service) {where service_id: service == "nil" ? nil : service}
  scope :start_date_filter, -> (start_date) {where("created_at >= ?", start_date)}
  scope :end_date_filter, -> (end_date) {where("created_at <= ?", end_date)}
  
  validates :amount,presence: true
  
  def client
    if self.client_id
      @client ||= Client.find(self.client_id)
    end
  end
  
  def service
    if self.service_id
      @service ||= Service.find(self.service_id)
    end
  end
  
  private
  
  
  def set_income_credentials
    self.acceptor = self.cash_box_session.cash_box.branch.title
    self.title = self.paid_service.service.title
    self.client_id = self.paid_service.client.id
    self.service_id = self.paid_service.service.id
  end
  
  def check_paid_service_lack
    self.paid_service.check_lack
  end
  
  def has_paid_service?
    !self.paid_service_id.nil?
  end
end
