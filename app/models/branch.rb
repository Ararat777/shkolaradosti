class Branch < ApplicationRecord
  has_many :services
  has_many :clients
  has_many :users
  has_many :single_discounts
  has_many :inventory_categories
  has_one :cash_box
  
  def manager
    @manager ||= self.users.find_by(:role_id => Role.find_by(:title => "Администратор").id)
  end
end
