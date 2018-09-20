require "fileutils"

module Pdfable
  extend ActiveSupport::Concern
  include Reportable
  
  included do
    has_one :report,as: :reportable
    after_create :make_report_pdf

    private

    def make_report_pdf
      report = self.build_report(
        :title => "#{self.class.name}_#{self.created_at.strftime("%F_%T")}",
        :path => "#{Rails.root}/app/reports/#{self.cash_box_session.cash_box.branch.title}/#{self.class.name}/#{self.created_at.year}/#{self.created_at.strftime('%B')}"
        )
      ReportPDF.new(:page_size => [560,2000]).make_report(self,report.path,"#{report.title}.pdf")
      report.save
    end
  end
end