require "fileutils"
class Report < ApplicationRecord
  include Reportable
  belongs_to :reportable,polymorphic: true
  before_create :generate_report_pdf
  
  private
  
  def generate_report_pdf
    parent = self.reportable 
    self.title = "#{parent.class.name}_#{self.created_at.strftime("%F")}"
    self.path = "#{Rails.root}/app/reports/#{parent.cash_box.branch.title}/#{parent.class.name}/#{self.created_at.year}/#{self.created_at.strftime('%B')}"

    FileUtils.mkdir_p(self.path)
    ReportPDF.new.make_report(parent,"#{self.path}/#{self.title}.pdf")
  end
end
