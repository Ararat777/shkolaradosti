class InventoryTransfer < ApplicationRecord
  has_and_belongs_to_many :inventory_categories
  enum :status => [:pending,:confirmed]
  
  validate :reciever_has_same_inventory_category
  
  def sender
    @sender ||= Branch.find(self.from_branch)
  end
  
  def reciever
    @reciever ||= Branch.find(self.to_branch)
  end
  
  def branch_inventory_category(branch,category_title)
    branch.inventory_categories.find_by(:title => category_title)
  end
  
  def exec_transfer
    [sender,reciever].each do |branch|
      inventory_category = branch_inventory_category(branch,self.inventory_category_title)
      if branch.id == self.from_branch
        inventory_category.size -= self.size
      else
        inventory_category.size += self.size
      end
      inventory_category.save
    end
    
    self.confirmed!
  end
  
  private
  
  def reciever_has_same_inventory_category
    if !reciever.inventory_categories.find_by(:title => self.inventory_category_title)
      errors.add(:to_branch,"Филиал полуатель не имеет такой категории")
    end
  end
end
