module Cancelable
  extend ActiveSupport::Concern
  
  included do
    scope :exist, -> () {where deleted_at: nil}
    
    def cancel!
      unless self.canceled?
        self.touch(:deleted_at)
        self.cash_box.calculate_cash
      end
    end
    
    def canceled?
      !self.deleted_at.nil?
    end
  end
  
end