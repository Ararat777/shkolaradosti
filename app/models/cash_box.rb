class CashBox < ApplicationRecord
  belongs_to :branch
  has_many :incomes
  has_many :consumptions
  has_many :encashments
  
  def transfers
    @transfers ||= Transfer.where(:from_cashbox => self[:id]).or(Transfer.where(:to_cashbox => self[:id]))
  end
end
