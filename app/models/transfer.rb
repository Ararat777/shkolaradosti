class Transfer < ApplicationRecord
  has_many :reports,as: :reportable
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
end
