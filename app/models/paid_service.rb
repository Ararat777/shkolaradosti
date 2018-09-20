class PaidService < ApplicationRecord
  include Reportable
  scope :countable, -> (){where(status: true).joins(:service).where(services: {countable: true})}
  scope :existing, -> (){where(canceled_at: nil)}
  has_one :days_count
  has_one :report,as: :reportable
  belongs_to :single_discount
  belongs_to :client
  belongs_to :service
  has_many :incomes
  after_create :set_days_count, if: :service_is_countable?
  after_create :report_for_client_pdf
  accepts_nested_attributes_for :incomes

  
  validates :client_id,presence: {message: "Клиент должен быть указан"}
  validates :service_id,presence: {message: "Услуга должна быть указана"}
  validates :start_date,presence: {message: "Дата начала услуги должна быть указана"}
  validates :end_date,presence: {message: "Дата конца услуги должна быть указана"}
  validates :required_amount,presence: {message: "Требуемая сумма должна быть указана"}
  validate :start_date_cannot_be_same_or_more_than_end_date
  
  
  def title
    @title ||= self.service.title
  end
  
  def check_status
    
    if self.status && self.end_date < Date.today
      self.update(status: false)
    elsif self.status == false && self.end_date > Date.today
      self.update(status: true)
    else
      self.status
    end
  end
  
  def countable_balance
    @balance ||= self.service.price * self.days_count.current_count_days
  end
  
  def remove_countable_balance(cash_box,params)
    self.update(:status => false)
    self.days_count.update(:current_count_days => 0)
    cash_box.exec_operation("consumptions",params).save
  end
  
  def check_lack
    self.update(lack: (self.required_amount - self.amount))
  end
  
  def decrement_days_count
    self.days_count.current_count_days -= 1
    self.days_count.save
  end
  
  def amount
    self.incomes.sum(:amount)
  end
  
  def canceled?
    self.canceled_at
  end
  
  def change_days_count
    count_days = Month.find_by(:year => self.end_date.year,:number => self.end_date.month).work_days_size
    self.days_count.update(:count_days => count_days + self.days_count.count_days,:current_count_days => count_days + self.days_count.current_count_days)
  end
  
  private
  
  def start_date_cannot_be_same_or_more_than_end_date
    if start_date.present? && end_date.present? && start_date > end_date || start_date == end_date
      errors.add(:start_date,"Дата начала не может быть равной или больше чем дата конца")
    end
  end
  
  def service_is_countable?
    self.service.countable
  end
  
  def set_days_count
    count_days = WorkDaysCalculator.new(self.start_date,self.end_date).call()
    self.create_days_count!(:count_days => count_days,:current_count_days => count_days)
  end
  
  def report_for_client_pdf
    report = self.build_report(
      :title => "Чек для клиента #{self.id}",
      :path => "#{Rails.root}/app/reports/#{self.client.branch.title}/ChecskForClients/#{self.created_at.year}/#{self.created_at.strftime('%B')}"
      )
    ReportPDF.new(:page_size => [560,2000]).make_check_for_client(self,report.path,"#{report.title}.pdf")
    report.save
  end
end
