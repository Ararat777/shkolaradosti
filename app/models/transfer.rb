class Transfer < ApplicationRecord
  include Reportable
  include Searchable
  enum :status => [:pending, :confirmed]
  
  def exec_transfer
    self.confirmed!
    CashBox.where(id: [self.from_cashbox,self.to_cashbox]).each do |item|
      item.calculate_cash
    end
  end
  
  def branch_sender
    Branch.find(self.from_cashbox)
  end
  
  def branch_acceptor
    Branch.find(self.to_cashbox)
  end
end
