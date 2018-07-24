class CashBox < ApplicationRecord
  belongs_to :branch
  has_many :incomes
  has_many :consumptions
  has_many :encashments
  
  def transfers
    @transfers ||= Transfer.where(:from_cashbox => self[:id]).or(Transfer.where(:to_cashbox => self[:id]))
  end
  
  def exec_operation(operation,params)
    self.send(operation).create(params)
  end
  
  def make_transfer(params)
    Transfer.create(params)
  end
  
  
  def calculate_cash
    self.cash = sum_operations("incomes") - sum_operations("consumptions") - sum_operations("encashments") + sum_operations("transfers")
    self.save
  end
  
  def sum_operations(operations)
    if operations != "transfers"
      self.send(operations).exist.sum(:amount)
    else
     Transfer.where(:to_cashbox => self[:id],:status => "confirmed").sum(:amount) - Transfer.where(:from_cashbox => self[:id],:status => "confirmed").sum(:amount)
    end
  end
end
