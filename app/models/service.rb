class Service < ApplicationRecord
  belongs_to :branch
  has_many :paid_services
end
