class Branch < ApplicationRecord
  has_many :services
  has_many :clients
  has_one :cash_box
  has_one :user
end
