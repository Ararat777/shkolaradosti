class Income < ApplicationRecord
  belongs_to :cash_box
  after_create :increase_cash_box_amount
  
  private
  
  def increase_cash_box_amount
    self.cash_box.cash += self.amount
    self.cash_box.save
  end
end
