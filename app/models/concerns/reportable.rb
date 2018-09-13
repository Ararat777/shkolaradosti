require "fileutils"

module Reportable
  
  class ReportPDF < Prawn::Document
    
    def initialize(options = {:page_size => "A4"})
      super(options)
      font "#{Rails.root}/app/assets/fonts/TimesNewRomanRegular.ttf"
    end
    
    def make_report(operation,path)
      data = [I18n.t("operations.#{operation.class.name}.table_titles")]
      arr = []
      arr << operation.branch_sender.title if operation.respond_to?(:branch_sender)
      arr << operation.branch_acceptor.title if operation.respond_to?(:branch_acceptor)
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

      text "Отчет за #{I18n.t("operations.#{operation.class.name}.rus")} #{Time.zone.now.strftime('%F_%T')}",align: :center,size: 20
      move_down(20)
      table(data,:position => :center)
      render_file(path)
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
    
    def cash_box_session_pdf(cash_box_session,path)
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
      render_file(path)
    end
  end
end