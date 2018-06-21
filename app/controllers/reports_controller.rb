class ReportsController < ApplicationController
  before_action :authenticate_booker_or_admin
  include ReportGenerator
  def index
    
  end
  
  def new
  end
  
  def make_report
    @collection = Object.const_get(report_params[:operation].capitalize).all
    filter_query(report_params)
    respond_to do |format|
      format.pdf do
        make_report_pdf(@collection)
      end
    end
  end
  
  
  private
  
  def make_report_pdf(collection)
    report = ReportPDF.new
    send_data report.make_report(collection),disposition: 'inline'
  end
  
  def filter_query(query)
    query.slice(:cash_box,:client,:service,:start_date,:end_date).each do |k,v|
      @collection = @collection.public_send(k,v)
    end
  end
  
  def report_params
    params.require(:make_report).permit(:operation,:cash_box,:client,:service,:start_date,:end_date)
  end
  
  def authenticate_booker_or_admin
    unless current_user.admin? || current_user.booker?
      flash[:error] = "У вас нет доступа!"
      redirect_to root_url
    end
  end
end
