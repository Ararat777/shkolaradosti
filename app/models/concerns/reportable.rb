require "fileutils"

module Reportable
  extend ActiveSupport::Concern
  
    included do
      
      class_eval do
        has_one :report,as: :reportable
        after_create :make_report_pdf

        private

        def make_report_pdf
          report = self.build_report
          report.title = "#{self.class.name}_#{self.created_at.strftime("%F")}"
          report.path = "#{Rails.root}/app/reports#{if self.respond_to?(:cash_box) then '/' + self.cash_box.branch.title end}/#{self.class.name}/#{self.created_at.year}/#{self.created_at.strftime('%B')}"

          FileUtils.mkdir_p(report.path)
          ReportPDF.new.make_report(self,"#{report.path}/#{report.title}.pdf")
          report.save
        end
      end
    end
  
  class ReportPDF < Prawn::Document
    
    def make_report(operation,path)
      font "#{Rails.root}/app/assets/fonts/TimesNewRomanRegular.ttf"
      data = [get_operation_header(operation)]
      
      if operation.class.name == "Transfer"
        data << 
        [operation.sender.title,operation.acceptor.title,operation.amount.to_s,operation.status.to_s,operation.created_at.strftime("%F %T").to_s,operation.comment.to_s]
        puts data
      else
        arr = []
        arr << operation.acceptor if operation.respond_to?(:acceptor)
        arr << operation.client.name if operation.respond_to?(:client)
        arr << operation.title if operation.respond_to?(:title)
        arr << operation.amount.to_s
        arr << operation.created_at.strftime("%F %T").to_s
        arr << operation.comment.to_s
        data << arr
      end
      text "Отчет за #{operation.class.name} #{Time.zone.now.strftime('%a, %d %b %Y %H:%M:%S')}",align: :center,size: 20
      move_down(20)
      table(data)
      render_file(path)
    end
    
    private
    
    def get_operation_header(operation)
      if operation.class.name == "Income"
        ["Филиал","Кто оплатил","Услуга","Сумма оплаты","Дата оплаты","Комментарий"]
      elsif operation.class.name == "Consumption"
        ["За что","Сумма оплаты","Дата оплаты","Комментарий"]
      elsif operation.class.name == "Encashment"
        ["Сумма","Дата инкасации","Комментарий"]
      elsif operation.class.name == "Transfer"
        ["Откуда","Куда","Сумма","Статус","Дата перевода","Комментарий"]
      end
    end
  end
end