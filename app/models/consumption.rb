class Consumption < ApplicationRecord
  include Reportable
  belongs_to :cash_box
  after_create :exec_consumption
  
  def exec_consumption
    self.cash_box.decrease_cash_box_amount(self.amount)
  end
end
