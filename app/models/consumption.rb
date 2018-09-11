class Consumption < ApplicationRecord
  include Pdfable
  include Searchable
  include Calculable
  belongs_to :cash_box_session
  
end
