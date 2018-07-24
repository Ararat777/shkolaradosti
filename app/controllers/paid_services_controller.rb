class PaidServicesController < ApplicationController
  
  before_action :set_paid_service, only: [:update,:edit,:surcharge,:destroy]
  def index
    @paid_services = @client.paid_services
  end
  
  def new
    @paid_service = PaidService.new
    @paid_service.incomes.build
  end
  
  def create
    @client = Client.find(paid_service_params[:client_id])
    if @paid_service = @client.has_active_paid_service?(paid_service_params[:service_id])
      
      if @paid_service.update(:end_date => paid_service_params[:end_date], :required_amount => @paid_service.required_amount + paid_service_params[:required_amount].to_f)
        @income = @paid_service.incomes.create(paid_service_params[:incomes_attributes]["0"])
        redirect_to income_path(@income.id)
      else
        render :new
      end
    else
      @paid_service = PaidService.new(paid_service_params)
      if @paid_service.save
          redirect_to income_path(@paid_service.incomes.last.id)
      else
          render :new
      end
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
    @paid_service.destroy
    redirect_to client_path(@paid_service.client.id)
  end
  
  
  def surcharge
    @income = @paid_service.incomes.new
  end
  
  def calculate_required_amount
    @paid_service = PaidService.new
    @paid_service.calculate_required_amount(calculating_params)
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def paid_service_params
    merged_params = params.require(:paid_service).permit(:service_id,:start_date,:end_date,:amount,:comment,:required_amount,:client_id,:single_discount_id,:incomes_attributes => [:amount])
    merged_params[:incomes_attributes]["0"].merge!(cash_box_id: current_cash_box.id)
    merged_params
  end
  
  def calculating_params
    params.require(:paid_service).permit(:service_id,:start_date,:end_date,:single_discount_id,:client_id)
  end
  
  def set_paid_service
     @paid_service = PaidService.find(params[:id])
  end
end
