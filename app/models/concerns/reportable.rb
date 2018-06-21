module Reportable
  extend ActiveSupport::Concern
  
  class ReportPDF < Prawn::Document
    
    def make_report(operation,path)
      font "#{Rails.root}/app/assets/fonts/TimesNewRomanRegular.ttf"
      if operation.class.name == "Income"
        header = ["Филиал","Кто оплатил","Услуга","Сумма оплаты","Дата оплаты","Комментарий"]
      elsif operation.class.name == "Consumption"
        header = ["За что","Сумма оплаты","Дата оплаты","Комментарий"]
      end
      data = [header]
      arr = []
      arr << operation.acceptor if operation.respond_to?(:acceptor)
      arr << Client.find(operation.client).name if operation.respond_to?(:client)
      arr << (operation.service ? Service.find(operation.service).title : operation.income_title) if operation.respond_to?(:service)
      arr << operation.consumption_title if operation.respond_to?(:consumption_title)
      arr << operation.amount.to_s
      arr << operation.created_at.to_s
      arr << operation.comment.to_s
      data << arr
      text "Отчет за #{operation.class.name} #{Time.zone.now.strftime('%a, %d %b %Y %H:%M:%S')}",align: :center,size: 20
      move_down(20)
      table(data)
      render_file(path)
    end
  end
end