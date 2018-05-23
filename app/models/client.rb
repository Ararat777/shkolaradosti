class Client < ApplicationRecord
  belongs_to :branch
  belongs_to :discount
  has_many :paid_services
  has_many :visited_days
  has_many :foods
end
