class Branch < ApplicationRecord
  has_many :services
  has_many :clients
  has_one :cash_box
  has_many :users
  
  def manager
    @manager ||= self.users.find_by(:role_id => Role.find_by(:title => "Администратор").id)
  end
end
