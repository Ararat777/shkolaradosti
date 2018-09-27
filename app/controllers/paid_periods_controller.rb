class PaidPeriodsController < ApplicationController
  before_action :set_paid_service,only: [:new,:create]
  
  def new
    @paid_period = @paid_service.paid_periods.new
    @paid_period.incomes.build
  end
  
  def show
    @paid_period = PaidPeriod.find(params[:id])
    respond_to do |format|
      format.pdf do
        report = @paid_period.report
        send_file report.path + report.title, :type => "application/pdf", :disposition => :inline
      end
    end
  end
  
  def create
    @paid_period = @paid_service.paid_periods.new(paid_period_params)
    if @paid_period.save
      redirect_to paid_service_path(@paid_service.id)
    else
      render :new
    end
  end
  
  def destroy
    
  end
  
  def calculate_required_amount
    @hh = RequireAmountCalculator.new(calculating_params).call()
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def set_paid_service
    @paid_service = PaidService.find(params[:paid_service_id])
  end
  
  def paid_period_params
    params.require(:paid_period).permit(:start_date,:end_date,:total_paid_days_size,:required_amount,:incomes_attributes => [:amount,:cash_box_session_id])
  end
  
  def calculating_params
    params.require(:paid_period_required_amount).permit(:service_id,:start_date,:end_date,:single_discount_id,:discount_client_id)
  end
end
