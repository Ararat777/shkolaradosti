class Consumption < ApplicationRecord
  belongs_to :cash_box
  after_create :make_consumption
  
  def make_consumption
    self.cash_box.decrease_cash_box_amount(self.amount)
  end
end
