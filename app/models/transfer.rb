class Transfer < ApplicationRecord
  include Reportable
  enum :status => [:pending, :confirmed]
  
  def exec_transfer
    CashBox.where(id: [self.from_cashbox,self.to_cashbox]).each do |item|
      if item.id == self.from_cashbox
        item.cash -= self.amount
      else
        item.cash += self.amount
      end
      item.save
    end
    self.confirmed!
  end
  
  def sender
    Branch.find(self.from_cashbox)
  end
  
  def acceptor
    Branch.find(self.to_cashbox)
  end
end
