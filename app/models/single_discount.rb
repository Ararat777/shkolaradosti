class SingleDiscount < ApplicationRecord
  has_many :paid_services
  belongs_to :branch
end
