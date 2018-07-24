class Encashment < ApplicationRecord
  include Reportable
  include Searchable
  include Cancelable
  include Calculable
  belongs_to :cash_box
  
 
end
