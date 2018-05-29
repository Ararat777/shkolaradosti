class PaidServicesController < ApplicationController
  
  before_action :set_paid_service, only: [:update,:edit]
  def index
    @paid_services = @client.paid_services
  end
  
  def new
    @paid_service = PaidService.new
  end
  
  def create
    @client = Client.find(paid_service_params[:client_id])
    if @paid_service = @client.has_active_paid_service?(paid_service_params[:service_id])
      
      if @paid_service.update(:end_date => paid_service_params[:end_date], :required_amount => @paid_service.required_amount + paid_service_params[:required_amount].to_f, :amount => @paid_service.amount + paid_service_params[:amount].to_f)
        
        if paid_service_params[:amount].to_i > 0
          current_cash_box.incomes.create(:service => paid_service_params[:service_id], :client => paid_service_params[:client_id], :amount => paid_service_params[:amount], :comment => "Оформление услуги")
        end
        redirect_to cashbox_path
        
      else
        render :new
      end
    else
      @paid_service = PaidService.new(paid_service_params)
      if @paid_service.save
        if @paid_service.amount > 0

          current_cash_box.incomes.create(:service => paid_service_params[:service_id], :client => paid_service_params[:client_id], :amount => paid_service_params[:amount], :comment => "Оформление услуги")
        end
        redirect_to cashbox_path
      else
        render :new
      end
    end
  end
  
  def edit
   @paid_service = PaidService.find(params[:id])
  end
  
  def update
    if @paid_service.update(:amount => (@paid_service.amount + paid_service_params[:amount].to_f), :end_date => paid_service_params[:end_date])
      if @paid_service.amount > 0
        current_cash_box.incomes.create(:service => @paid_service.service.id, :client => @client.id, :amount => paid_service_params[:amount], :comment => "Доплата за услугу #{@paid_service.service.title}")
      end
      redirect_to cashbox_path
    else
      render :edit
    end
  end
  
  private
  
  def paid_service_params
    params.require(:paid_service).permit(:service_id,:start_date,:end_date,:amount,:comment,:required_amount,:client_id)
  end
  
  def set_paid_service
     @paid_service = PaidService.find(params[:id])
  end
end
