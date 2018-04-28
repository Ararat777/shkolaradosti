class Encashment < ApplicationRecord
  belongs_to :cash_box
  after_create :make_encashment
  
  def make_encashment
    self.cash_box.decrease_cash_box_amount(self.amount)
  end
end
