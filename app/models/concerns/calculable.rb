module Calculable
  extend ActiveSupport::Concern
  included do
    after_create :calculate_cash_box_cash
    
    private
    
    def calculate_cash_box_cash
      self.cash_box.calculate_cash
    end
  end
end