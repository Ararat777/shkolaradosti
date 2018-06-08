module Reportable
  extend ActiveSupport::Concern
  
  class Report < Prawn::Document
    def make_incomes_report(collection)
      font "#{Rails.root}/app/assets/fonts/TimesNewRomanRegular.ttf"
      header = ["Филиал","Кто оплатил","Услуга","Сумма оплаты","Дата оплаты","Комментарий"]
      data = [header]
      collection.each do |item|
        data << [
          item.acceptor,
          Client.find(item.client).name,
          item.service ? Service.find(item.service).title : item.title,
          item.amount.to_s,
          item.created_at.to_s,
          item.comment.to_s
          ]
      end
      text "Отчет по приходам на #{Time.zone.now.strftime('%a, %d %b %Y %H:%M:%S')}",align: :center,size: 20
      move_down(20)
      table(data)
      render
    end
  end
end