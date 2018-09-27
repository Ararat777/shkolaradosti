class PaidServicesController < ApplicationController
  
  before_action :set_paid_service, only: [:show,:update,:edit,:surcharge,:destroy,:new_renewal,:renewal]
  
  
  def new
    @paid_service = PaidService.new
    @paid_period = @paid_service.paid_periods.build
    @paid_period.incomes.build
  end
  
  def show
    @paid_periods = @paid_service.paid_periods
  end
  
  def create
    @paid_service = PaidService.new(paid_service_params)
    if @paid_service.save
      redirect_to paid_service_path(@paid_service.id)
    else
      flash[:error] = @paid_service.errors.full_messages
      render :new
    end
  end
  
  private
  
  def paid_service_params
    params.require(:paid_service).permit(:service_id,:comment,:client_id,:paid_periods_attributes => [:required_amount,:start_date,:end_date,:incomes_attributes => [:amount,:cash_box_session_id]])
  end
  
  def set_paid_service
     @paid_service = PaidService.find(params[:id])
  end
end
