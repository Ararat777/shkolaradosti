class PaidServicesController < ApplicationController
  
  before_action :set_paid_service, only: [:update,:edit,:surcharge,:destroy,:new_renewal,:renewal]
  
  
  def new
    @paid_service = PaidService.new
    @paid_service.incomes.build
  end
  
  def create
    @paid_service = PaidService.new(paid_service_params)
    if @paid_service.save
      redirect_to income_path(@paid_service.incomes.last.id)
    else
      render :new
    end
  end
  
  def edit
   @paid_service = PaidService.find(params[:id])
  end
  
  def update
    @paid_service.incomes.build
    if @paid_service.update(paid_service_params)
      redirect_to income_path(@paid_service.incomes.last.id)
    else
      render :edit
    end
  end
  
  def destroy
    @paid_service.update(status: false,canceled_at: Time.now)
    redirect_to client_path(@paid_service.client.id)
  end
  
  def new_renewal
    @paid_service.required_amount = PaidServiceExtender.required_amount_for_renewal(@paid_service) if @paid_service.service.countable
  end
  
  def renewal
    @paid_service.update(renewal_paid_service_params)
    @paid_service.change_days_count if @paid_service.service.countable
    redirect_to income_path(@paid_service.incomes.last)
  end
  
  def surcharge
    @income = @paid_service.incomes.new
  end
  
  def calculate_required_amount
    @required_amount = RequireAmountCalculator.new(calculating_params).call()
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def paid_service_params
    params.require(:paid_service).permit(:service_id,:start_date,:end_date,:comment,:required_amount,:client_id,:single_discount_id,:incomes_attributes => [:amount,:cash_box_session_id])
  end
  
  def calculating_params
    params.require(:paid_service_required_amount).permit(:service_id,:start_date,:end_date,:single_discount_id,:discount_client_id)
  end
  
  def set_paid_service
     @paid_service = PaidService.find(params[:id])
  end
  
  def renewal_paid_service_params
    params[:paid_service][:required_amount] = params[:paid_service][:required_amount].to_f + @paid_service.required_amount
    params.require(:paid_service).permit(:end_date,:required_amount,:single_discount_id,:incomes_attributes => [:amount,:cash_box_session_id])
  end
end
