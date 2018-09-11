class Service < ApplicationRecord
  belongs_to :branch
  has_many :paid_services
  
  def discount_price(single_discount_id)
    discount = SingleDiscount.find(single_discount_id)
    if discount.fixed
      self.price - discount.discount_size
    else
      self.price * (1 - (discount.discount_size.to_f / 100))
    end
  end
  
  def discount_client_price(client)
    self.price * (1 - (client.discount.discount_size.to_f / 100))
  end
end
