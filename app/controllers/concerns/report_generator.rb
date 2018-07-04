module ReportGenerator
  extend ActiveSupport::Concern
  
  class ReportPDF < Prawn::Document
    
    def make_report(collection)
      font "#{Rails.root}/app/assets/fonts/TimesNewRomanRegular.ttf"
      operation = collection.class.to_s.split("::").first
      if operation == "Income"
        header = ["Филиал","Кто оплатил","Услуга","Сумма оплаты","Дата оплаты","Комментарий"]
      elsif operation == "Consumption"
        header = ["За что","Сумма оплаты","Дата оплаты","Комментарий"]
      end
      data = [header]
      collection.each do |item|
        arr = []
        arr << item.acceptor if item.respond_to?(:acceptor)
        arr << item.client.name if item.respond_to?(:client)
        arr << item.title if item.respond_to?(:title)
        arr << item.amount.to_s
        arr << item.created_at.strftime("%F %T").to_s
        arr << item.comment.to_s
        data << arr
      end
      text "Отчет по приходам на #{Time.zone.now.strftime("%F %T")}",align: :center,size: 20
      move_down(20)
      table(data)
      render
    end
  end
end