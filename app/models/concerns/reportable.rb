require "fileutils"

module Reportable
  
  class ReportPDF < Prawn::Document
    
    def initialize(options = {:page_size => "A4"})
      super(options)
      font "#{Rails.root}/app/assets/fonts/Calibri.ttf"
      @logo_path = "#{Rails.root}/app/assets/images/logo.png"
    end
    
    def check_for_client(income)
       
    end
    
    def make_report(operation,path,file)
      dash 5
      move_down(30)
      #image @logo_path, width: 480
      move_down(50)
      stroke_horizontal_line 0,485
      move_down(30)
      text "#{I18n.t("operations.#{operation.class.name}.order")} ОРДЕР",align: :center,size: 30
      move_down(24)
      stroke_horizontal_line 0,485
      move_down(50)
      text operation.respond_to?(:acceptor) ? operation.acceptor : operation.cash_box_session.cash_box.branch.title,size: 30
      text operation.created_at.strftime("%T | %F"),size: 30
      move_down(24)
      if operation.respond_to?(:title)
        text "Платеж:",size: 30
        text operation.title,size: 30
        move_down(30)
      end
      text "Сумма:",size: 30
      text "#{operation.amount} грн.",size: 30
      move_down(24)
      if operation.respond_to?(:client)
        if operation.client
          text "Оплатил:",size: 30
          text operation.client.name,size: 30
          move_down(24)
        end
      end
      text "Примечание:",size: 30
      text operation.comment,size: 30
      move_down(44)
      stroke_horizontal_line 0,485
      move_down(30)
      text "Принял: Сухомлинов В.К.",size: 30
      move_down(10)
      text "Подпись",size: 30
      move_down(30)
      undash
      stroke_horizontal_line 0,240
      #arr = []
      #arr << operation.branch_sender.title if operation.respond_to?(:branch_sender)
      #arr << operation.branch_acceptor.title if operation.respond_to?(:branch_acceptor)
      #arr << operation.acceptor if operation.respond_to?(:acceptor)
      #if operation.respond_to?(:client)
      #  arr << (operation.client ? operation.client.name : "")
      #end
      #arr << operation.title if operation.respond_to?(:title)
      #arr << operation.amount.to_s
      #arr << operation.status.to_s if operation.respond_to?(:status)
      #arr << operation.created_at.strftime("%F %T").to_s
      #arr << operation.comment.to_s
      #data << arr

      #text "Отчет за #{I18n.t("operations.#{operation.class.name}.rus")} #{Time.zone.now.strftime('%F_%T')}",align: :center,size: 20
      #move_down(20)
      #table(data,:position => :center)
      FileUtils.mkdir_p(path)
      render_file("#{path}/#{file}")
    end
    
    def generate_report(collection)
      operation = collection.klass.name
      data = [I18n.t("operations.#{operation}.table_titles")]
      collection.each do |item|
        arr = []
        arr << item.sender.branch.title if item.respond_to?(:sender)
          arr << item.reciever.branch.title if item.respond_to?(:reciever)
        arr << item.acceptor if item.respond_to?(:acceptor)
        if item.respond_to?(:client)
          arr << (item.client ? item.client.name : "")
        end
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
      table(data,:position => :center)
      render
    end
    
    def cash_box_session_pdf(cash_box_session,path,file)
      text "Отчет по кассовой смене №#{cash_box_session.id}",align: :center,size: 22
      ["incomes","consumptions","encashments","transfers"].each do |item|
        data = [I18n.t("operations.#{item.capitalize.chop}.table_titles")]
        cash_box_session.send(item).each do |operation|
          arr = []
          arr << operation.sender.branch.title if operation.respond_to?(:sender)
          arr << operation.reciever.branch.title if operation.respond_to?(:reciever)
          arr << operation.acceptor if operation.respond_to?(:acceptor)
          if operation.respond_to?(:client)
            arr << (operation.client ? operation.client.name : "")
          end
          arr << operation.title if operation.respond_to?(:title)
          arr << operation.amount.to_s
          arr << operation.status.to_s if operation.respond_to?(:status)
          arr << operation.created_at.strftime("%F %T").to_s
          arr << operation.comment.to_s
          data << arr
        end
        text I18n.t("operations.#{item.capitalize.chop}.rus"),align: :center,size: 20
        move_down(10)
        table(data,:position => :center)
        move_down(20)
      end
      FileUtils.mkdir_p(path)
      render_file("#{path}/#{file}")
    end
    
    def make_check_for_client(paid_service,path,file)
      dash 5
      move_down(30)
      #image @logo_path, width: 480
      move_down(50)
      stroke_horizontal_line 0,485
      move_down(30)
      text "ФОП Сухомлинова Н.В.",align: :center,size: 30
      text "***",align: :center,size: 30
      text "ИНН 3340104773",align: :center,size: 30
      move_down(30)
      stroke_horizontal_line 0,485
      move_down(50)
      text paid_service.client.branch.title,size: 30
      text paid_service.created_at.strftime("%T | %F"),size: 30
      move_down(30)
      text "1.#{paid_service.service.title}    x#{paid_service.service.countable ? paid_service.days_count.count_days : 1}    #{paid_service.required_amount}грн",size: 30
      move_down(50)
      stroke_horizontal_line 0,485
      move_down(30)
      text "SHKOLARADOSTI.COM.UA",align: :center,size: 30
      move_down(30)
      stroke_horizontal_line 0,485
      move_down(30)
      text "(057) 755 20 10",align: :center,size: 30
      text "(094) 815 20 10",align: :center,size: 30
      move_down(30)
      stroke_horizontal_line 0,485
      move_down(30)
      text "НЕ ФИСКАЛЬНЫЙ ЧЕК",align: :center,size: 30
      move_down(30)
      stroke_horizontal_line 0,485
      FileUtils.mkdir_p(path)
      render_file("#{path}/#{file}")
    end
  end
end