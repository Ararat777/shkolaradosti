module PaidServiceExtender
  
  def self.required_amount_for_renewal(paid_service)
    next_month_work_days = WorkDaysCalculator.new(paid_service.end_date,(paid_service.end_date + 1.month).end_of_month).call()
    rest_work_days = WorkDaysCalculator.new(Date.today + 1.day,paid_service.end_date).call()
    rest_count_days = paid_service.days_count.current_count_days
    next_month_work_days -= (rest_count_days - rest_work_days) if rest_count_days > rest_work_days
    paid_service.service.price * next_month_work_days
  end
  
end
