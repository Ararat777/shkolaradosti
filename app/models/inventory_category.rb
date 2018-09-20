class InventoryCategory < ApplicationRecord
  has_and_belongs_to_many :transfers,class_name: "InventoryTransfer"
  belongs_to :branch
end
