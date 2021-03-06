class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :branch
  belongs_to :role
  
  def admin?
    self.role_id.nil?
  end
  
  def admin_of_branch?
    unless self.admin?
      self.role.id == 1
    end
  end
  
  def booker?
    unless self.admin?
      self.role.id == 2
    end
  end
end
