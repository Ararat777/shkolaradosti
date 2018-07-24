require "fileutils"

module Reportable
  extend ActiveSupport::Concern
  
    included do
      
      class_eval do
        if self != Report
          has_one :report,as: :reportable
          after_create :make_report_pdf

          private

          def make_report_pdf
            report = self.build_report
            report.title = "#{self.class.name}_#{self.created_at.strftime("%F")}"
            report.path = "#{Rails.root}/app/reports#{if self.respond_to?(:cash_box) then '/' + self.cash_box.branch.title end}/#{self.class.name}/#{self.created_at.year}/#{self.created_at.strftime('%B')}"

            FileUtils.mkdir_p(report.path)
            ReportPDF.new(:page_size => [570,2000]).make_report(self,"#{report.path}/#{report.title}.pdf")
            report.save
          end
        end
      end
    end
  
  class ReportPDF < Prawn::Document
    
    def initialize(options = {:page_size => "A4"})
      super(options)
    end
    
    def make_report(operation,path)
      font "#{Rails.root}/app/assets/fonts/TimesNewRomanRegular.ttf"
      data = [get_operation_header(operation.class.name)]
      
      arr = []
      arr << operation.branch_sender.title if operation.respond_to?(:branch_sender)
      arr << operation.branch_acceptor.title if operation.respond_to?(:branch_acceptor)
      arr << operation.acceptor if operation.respond_to?(:acceptor)
      arr << operation.client.name if operation.respond_to?(:client)
      arr << operation.title if operation.respond_to?(:title)
      arr << operation.amount.to_s
      arr << operation.status.to_s if operation.respond_to?(:status)
      arr << operation.created_at.strftime("%F %T").to_s
      arr << operation.comment.to_s
      data << arr

      text "Отчет за #{operation.class.name} #{Time.zone.now.strftime('%a, %d %b %Y %H:%M:%S')}",align: :center,size: 20
      move_down(20)
      table(data)
      render_file(path)
    end
    
    def generate_report(collection)
      font "#{Rails.root}/app/assets/fonts/TimesNewRomanRegular.ttf"
      operation = collection.klass.name
      data = [get_operation_header(operation)]
      collection.each do |item|
        arr = []
        arr << item.branch_sender.title if item.respond_to?(:branch_sender)
        arr << item.branch_acceptor.title if item.respond_to?(:branch_acceptor)
        arr << item.acceptor if item.respond_to?(:acceptor)
        arr << item.client.name if item.respond_to?(:client)
        arr << item.title if item.respond_to?(:title)
        arr << item.amount.to_s
        arr << item.status.to_s if item.respond_to?(:status)
        arr << item.created_at.strftime("%F %T").to_s
        arr << item.comment.to_s
        data << arr
      end
      puts data.inspect
      text "Отчет по приходам на #{Time.zone.now.strftime("%F %T")}",align: :center,size: 20
      move_down(20)
      table(data)
      render
    end
    
    private
    
    def get_operation_header(operation_name)
      if operation_name == "Income"
        ["Филиал","Кто оплатил","Услуга","Сумма оплаты","Дата оплаты","Комментарий"]
      elsif operation_name == "Consumption"
        ["За что","Сумма оплаты","Дата оплаты","Комментарий"]
      elsif operation_name == "Encashment"
        ["Сумма","Дата инкасации","Комментарий"]
      elsif operation_name == "Transfer"
        ["Откуда","Куда","Сумма","Статус","Дата перевода","Комментарий"]
      end
    end
  end
end