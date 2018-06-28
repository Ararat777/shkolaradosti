class PaidService < ApplicationRecord
  has_one :days_count
  belongs_to :single_discount
  belongs_to :client
  belongs_to :service
  before_save :check_lack
  after_create :set_days_count, if: :service_is_food?
  
  def title
    self.service.title
  end
  
  def check_status
    
    if self.status && self.end_date < Date.today
      self.update(:status => false)
      self.status
    end
    
    self.status
    
  end
  
  def food_balance
    self.service.price * self.days_count.current_count_days
  end
  
  def remove_food_balance
    balance = food_balance
    self.days_count.update(:current_count_days => 0)
    balance
  end
  
  def check_lack
    if self.required_amount != self.amount
      self.lack = self.required_amount - self.amount
    else
      self.lack = 0
    end
  end
  
  def calculate_required_amount(service_id,start_date,end_date,single_discount_id,client_id)
    service = Service.find(service_id)
    price = service.price
    month_work_days = Month.find_by(:year => start_date.year,:number => start_date.month).work_days_size
    
    if service.title != "Питание"
      if single_discount_id.present?
        price = service.discount_price(single_discount_id)
      elsif client_id.present?
        price = service.discount_client_price(client_id)
      end
      self.required_amount = ((price / month_work_days) * calculate_work_days(start_date,end_date)).round
    else
      self.required_amount = price * calculate_work_days(start_date,end_date)
    end
  end
  
  
  
  private
  
  def calculate_work_days(start_date,end_date)
    calculated_work_days = (start_date..end_date).select{|x| x.strftime("%a") != "Sat" && x.strftime("%a") != "Sun" }.size
    calculated_work_days += ExceptionalDay.where(:is_holiday => false,:day => start_date..end_date).size
    calculated_work_days -= ExceptionalDay.where(:is_holiday => true,:day => start_date..end_date).size
  end
  
  def service_is_food?
    self.service.title == "Питание"
  end
  
  def set_days_count
    count_days = calculate_work_days(self.start_date,self.end_date)
    self.create_days_count!(:count_days => count_days,:current_count_days => count_days)
  end
end
