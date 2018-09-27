class PaidService < ApplicationRecord
  scope :existing, -> (){where(canceled_at: nil)}
  belongs_to :client
  belongs_to :service
  has_many :paid_periods
  has_many :incomes,through: :paid_periods
  accepts_nested_attributes_for :paid_periods
  
  validates :client_id,presence: {message: "Клиент должен быть указан"}
  validates :service_id,presence: {message: "Услуга должна быть указана"}
  
  def title
    @title ||= self.service.title
  end
  
  def self.countable
    joins(:service).where(services: {countable: true})
  end
  
  def active?
    self.paid_periods.active
  end
  
  def countable_balance
    @balance ||= self.service.price * self.paid_periods
  end
  
  def update_rest_paid_days
    self.paid_periods.active.decrement_paid_days
  end
  
  def update_total_information
    self.update_attributes(
      :total_required_amount => self.paid_periods.collect(&:required_amount).sum,
      :total_paid_amount => self.incomes.collect(&:amount).sum,
      :total_lack => self.paid_periods.collect(&:lack).sum
        )
  end
  
  def canceled?
    self.canceled_at
  end
end
