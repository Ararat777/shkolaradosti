class CashBoxSessionsController < ApplicationController
  
  def index
    @cash_box_sessions = current_cash_box.cash_box_sessions.where.not(:closed_at => nil)
  end
  
  def show
    @cash_box_session = CashBoxSession.find(params[:id])
    report = @cash_box_session.report
    respond_to do |format|
      format.pdf do
        send_file("#{report.path}/#{report.title}.pdf",disposition: :inline)
      end
    end
  end
  
  def create
    @cash_box_session = current_cash_box.cash_box_sessions.new
    if @cash_box_session.save
      flash[:notice] = "Кассовая смена №#{@cash_box_session.id} открыта"
      redirect_to cashbox_path
    else
      flash[:error] = @cash_box_session.errors
      render 'cash_boxes/show'
    end
  end
  
  def update
    @cash_box_session = CashBoxSession.find(params[:id])
    @cash_box_session.touch(:closed_at)
    @cash_box_session.make_cash_box_session_pdf
    redirect_to cashbox_path
  end
  
  
end
