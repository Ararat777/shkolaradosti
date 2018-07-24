module Searchable
  extend ActiveSupport::Concern
  
  included do
    scope :start_date_filter, -> (start_date) {where("created_at >= ?", start_date)}
    scope :end_date_filter, -> (end_date) {where("created_at <= ?", end_date)}
  end
end