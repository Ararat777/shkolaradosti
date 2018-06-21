class CashBox < ApplicationRecord
  belongs_to :branch
  has_many :incomes,after_add: :make_report_pdf
  has_many :consumptions,after_add: :make_report_pdf
  has_many :encashments,after_add: :make_report_pdf
  
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
  
  private
  
  def make_report_pdf(operation)
    operation.reports.create
  end
end
