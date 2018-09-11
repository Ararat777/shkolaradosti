class CashBox < ApplicationRecord
  belongs_to :branch
  has_many :cash_box_sessions
  has_many :incomes,through: :cash_box_sessions
  has_many :consumptions,through: :cash_box_sessions
  has_many :encashments,through: :cash_box_sessions
  
  def current_cash_box_session
    @current_cash_box_session ||= self.cash_box_sessions.find_by(:closed_at => nil)
  end
  
  
  def exec_operation(operation,params)
    self.current_cash_box_session.send(operation).new(params)
  end
  
  
  def update_cash
    self.cash = sum_operations("incomes") - sum_operations("consumptions") - sum_operations("encashments")
    self.save
  end
  
  def sum_operations(operations)
    self.current_cash_box_session.send(operations).sum(:amount)
  end
end
