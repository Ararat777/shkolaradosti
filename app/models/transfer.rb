class Transfer < ApplicationRecord
  enum :status => [:pending, :confirmed]
  has_and_belongs_to_many :cash_box_sessions
  after_create :set_cash_box_sessions
  validate :reciever_cash_box_session_is_opened
  
  def exec_transfer
    self.sender.exec_operation("consumptions",{:title => "Перемещение средств в #{self.reciever.branch.title}", :amount => self.amount, :comment => "Перемещение средств в #{self.reciever.branch.title}"}).save
    
    self.reciever.exec_operation("incomes",{:acceptor => self.reciever.branch.title,:title => "Получение средств от #{self.sender.branch.title}", :amount => self.amount, :comment => "Получение средств от #{self.sender.branch.title}"}).save
    
    self.confirmed!
  end
  
  def sender
    @sender ||= self.cash_box_sessions.find_by(:cash_box_id => self.from_cashbox).cash_box
  end
  
  def reciever
    @reciever ||= self.cash_box_sessions.find_by(:cash_box_id => self.to_cashbox).cash_box
  end
  
  private
  
  def set_cash_box_sessions
    self.cash_box_sessions << CashBox.find(self.from_cashbox).current_cash_box_session
    self.cash_box_sessions << CashBox.find(self.to_cashbox).current_cash_box_session
  end
  
  def reciever_cash_box_session_is_opened
    if !CashBox.find(self.to_cashbox).current_cash_box_session
      errors.add(:to_cashbox, "Кассовая смена филиала-получателя еще не открыта")
    end
  end
end
