class ReportsController < ApplicationController
  include Reportable
  def incomes
    @incomes = Income.all
    filter_query(params[:q]) if params[:q]
    respond_to do |format|
      format.html {}
      format.pdf do
        report = Report.new
        send_data report.make_incomes_report(@incomes)
      end
    end
  end
  
  
  
  private
  
  def filter_query(query)
    query.slice(:cash_box,:client,:service,:start_date,:end_date).each do |k,v|
      @incomes = @incomes.public_send(k,v)
    end
  end
end
