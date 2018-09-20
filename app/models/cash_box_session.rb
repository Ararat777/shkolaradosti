class CashBoxSession < ApplicationRecord
  include Reportable
  default_scope {order(created_at: :asc)}
  belongs_to :cash_box
  has_many :incomes
  has_many :consumptions
  has_many :encashments
  has_and_belongs_to_many :transfers
  has_one :report,as: :reportable
  after_create :make_income,if: :cash_box_has_cash?
  
  def make_cash_box_session_pdf
    report = self.build_report(:title => "Отчет кассовой смены №#{self.id}",:path => "#{Rails.root}/app/reports/#{self.cash_box.branch.title}/CashBoxSessions")
    ReportPDF.new.cash_box_session_pdf(self,report.path,"#{report.title}.pdf")
    report.save
  end
  
  private
  
  def make_income
    self.incomes.create(:amount => self.cash_box.cash,:title => "Остаток за #{self.cash_box.cash_box_sessions.where.not(:closed_at => nil).first.closed_at.strftime("%F")}")
  end
  
  def cash_box_has_cash?
    self.cash_box.cash > 0
  end
  
  
end
