require "prawn"
class Income < ApplicationRecord
  belongs_to :cash_box
  after_create :make_income,:generate_pdf
  
  private
  
  def make_income
    self.cash_box.increase_cash_box_amount(self.amount)
  end
  
  def generate_pdf
    income = self
    Prawn::Document.generate("#{Rails.root}/app/documents/incomes/#{income.id.to_s}.pdf") do
       text "#{income.id}"
       text "#{income.service}"
       text "#{income.client}"
       text "#{income.amount}"
    end
  end
end
