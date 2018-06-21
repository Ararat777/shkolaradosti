class Consumption < ApplicationRecord
  belongs_to :cash_box
  after_create :make_consumption
  has_many :reports,as: :reportable
  
  def make_consumption
    self.cash_box.decrease_cash_box_amount(self.amount)
  end
end
