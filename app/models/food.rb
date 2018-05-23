class Food < ApplicationRecord
  belongs_to :client
  after_initialize :set_food_price
  before_create :set_count_days
  
  private
  
  def set_count_days
    self.count_days = self.paid_days.to_i
  end
  
  def set_food_price
    self.price = Service.find_by(:title => "Питание").price
  end
end
