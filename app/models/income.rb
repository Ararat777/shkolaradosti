require "prawn"
class Income < ApplicationRecord
  belongs_to :cash_box
  after_create :make_income
  scope :cash_box, -> (cash_box) {where cash_box_id: cash_box}
  scope :client, -> (client) {where client: client}
  scope :service, -> (service) {where service: service}
  scope :start_date, -> (start_date) {where("created_at >= ?", start_date)}
  scope :end_date, -> (end_date) {where("created_at <= ?", end_date)}
  
  private
  
  def make_income
    self.cash_box.increase_cash_box_amount(self.amount)
  end
end
