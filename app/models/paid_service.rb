class PaidService < ApplicationRecord
  scope :countable, -> (){where(status: true).joins(:service).where(services: {countable: true})}
  has_one :days_count
  belongs_to :single_discount
  belongs_to :client
  belongs_to :service
  has_many :incomes
  after_create :set_days_count, if: :service_is_countable?
  accepts_nested_attributes_for :incomes

  
  validates :client_id,presence: {message: "Клиент должен быть указан"}
  validates :service_id,presence: {message: "Услуга должна быть указана"}
  validates :start_date,presence: {message: "Дата начала услуги должна быть указана"}
  validates :end_date,presence: {message: "Дата конца услуги должна быть указана"}
  validates :required_amount,presence: {message: "Требуемая сумма должна быть указана"}
  validate :start_date_cannot_be_same_or_more_than_end_date
  
  
  def title
    self.service.title
  end
  
  def check_status
    
    if self.status && self.end_date < Date.today
      self.update(status: false)
      self.status
    end
    
    self.status
    
  end
  
  def countable_balance
    self.service.price * self.days_count.current_count_days
  end
  
  def remove_countable_balance
    balance = countable_balance
    self.days_count.update(:current_count_days => 0)
    self.update(:status => false)
    balance
  end
  
  def check_lack
    self.update(lack: (self.required_amount - self.amount))
  end
  
  def calculate_required_amount(params)
    service = Service.find(params[:service_id])
    month_work_days = Month.find_by(:year => params[:start_date].to_date.year,:number => params[:start_date].to_date.month).work_days_size
    price = service.price
    if service.title != "Питание"
      if params[:single_discount_id].present?
        price = service.discount_price(params[:single_discount_id])
      elsif params[:client_id].present?
        client = Client.find(params[:client_id])
        if client.discount
          price = service.discount_client_price(client)
        end
      end
      ((price / month_work_days) * calculate_work_days(params[:start_date].to_date,params[:end_date].to_date)).round
    else
      price * calculate_work_days(params[:start_date].to_date,params[:end_date].to_date)
    end
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
  
  private
  
  def start_date_cannot_be_same_or_more_than_end_date
    if start_date.present? && end_date.present? && start_date > end_date || start_date == end_date
      errors.add(:start_date,"Дата начала не может быть равной или больше чем дата конца")
    end
  end
  
  def required_amount_has_right_value
    if required_amount.present? && required_amount != calculate_required_amount({:service_id => service_id,:start_date => start_date,:end_date => end_date,:single_discount_id => single_discount_id,:client_id => client_id})
      errors.add(:required_amount, "Неверная требуемая сумма!")
    end
  end
  
  def calculate_work_days(start_date,end_date)
    calculated_work_days = (start_date..end_date).select{|x| x.strftime("%a") != "Sat" && x.strftime("%a") != "Sun" }.size
    calculated_work_days += ExceptionalDay.where(:is_holiday => false,:day => start_date..end_date).size
    calculated_work_days -= ExceptionalDay.where(:is_holiday => true,:day => start_date..end_date).size
  end
  
  def service_is_countable?
    self.service.countable
  end
  
  def set_days_count
    count_days = calculate_work_days(self.start_date,self.end_date)
    self.create_days_count!(:count_days => count_days,:current_count_days => count_days)
  end
end
