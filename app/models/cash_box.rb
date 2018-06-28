class CashBox < ApplicationRecord
  belongs_to :branch
  has_many :incomes
  has_many :consumptions
  has_many :encashments
  
  def transfers
    @transfers ||= Transfer.where(:from_cashbox => self[:id]).or(Transfer.where(:to_cashbox => self[:id]))
  end
  
  def make_income(params)
    self.incomes.create(params)
  end
  
  def make_consumption(params)
    self.consumptions.create(params)
  end
  
  def make_encashment(params)
    self.encashments.create(params)
  end
  
  def make_transfer(params)
    Transfer.create(params)
  end
  
  def increase_cash_box_amount(amount)
    self.cash += amount
    self.save
  end
  
  def decrease_cash_box_amount(amount)
    self.cash -= amount
    self.save
  end
  
end
