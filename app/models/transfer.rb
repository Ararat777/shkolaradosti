class Transfer < ApplicationRecord
  enum :status => [:pending, :confirmed]
end
