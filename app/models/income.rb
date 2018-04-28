class Income < ApplicationRecord
  belongs_to :cash_box
  after_create :make_income
  
  private
  
  def make_income
    self.cash_box.increase_cash_box_amount(self.amount)
  end
end
