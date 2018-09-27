class PaidPeriod < ApplicationRecord
  include Reportable
  default_scope {order(id: :desc)}
  scope :active, ->(){find_by(active: true)}
  has_one :report,as: :reportable
  belongs_to :paid_service
  has_many :incomes
  before_create :set_title
  before_create :set_countable_information,if: :countable_service?
  before_create :set_status
  before_save :set_paid_amount
  after_save :update_paid_service_information
  after_create :report_for_client_pdf
  accepts_nested_attributes_for :incomes
  
  def service
    self.paid_service.service
  end
  
  def decrement_paid_days
    self[:rest_paid_days_size] -= 1
    update_countable_balance
    self.save
  end
  
  private
  
  def set_title
    self[:title] = I18n.t("date.month_names")[self.start_date.month]
  end
  
  def countable_service?
    self.paid_service.service.countable
  end
  
  def set_countable_information
    self[:rest_paid_days_size] = self.total_paid_days_size
    update_countable_balance
  end
  
  def update_countable_balance
    self[:countable_balance] = self[:rest_paid_days_size] * self.service.price
  end
  
  def set_paid_amount
    self.paid_amount = self.incomes.collect(&:amount).sum
  end
  
  def update_paid_service_information
    self.paid_service.update_total_information
  end
  
  def set_status
    if start_date <= Date.today && end_date >= Date.today
      self[:active] = true
    else
      self[:active] = false
    end
  end
  
  def report_for_client_pdf
    report = self.build_report(
      :title => "Чек для клиента #{self.id}.pdf",
      :path => "#{Rails.root}/app/reports/#{self.paid_service.client.branch.title}/ChecskForClients/#{self.created_at.year}/#{self.created_at.strftime('%B')}/"
      )
    ReportPDF.new(:page_size => [560,2000]).make_check_for_client(self,report.path,report.title)
    report.save
  end
  
end
