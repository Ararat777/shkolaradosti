class Report < ApplicationRecord
  include Reportable
  belongs_to :reportable,polymorphic: true
  
  
  def generate_report_pdf(collection)
    ReportPDF.new.generate_report(collection)
  end
end
