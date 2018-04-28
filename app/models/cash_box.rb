class CashBox < ApplicationRecord
  belongs_to :branch
  has_many :incomes
  has_many :consumptions
  has_many :encashments
  
  def transfers
    @transfers ||= Transfer.where(:from_cashbox => self[:id]).or(Transfer.where(:to_cashbox => self[:id]))
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
