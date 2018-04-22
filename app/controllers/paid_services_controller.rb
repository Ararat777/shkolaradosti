class PaidServicesController < ApplicationController
  before_action :set_client
  before_action :set_paid_service, only: [:update,:edit]
  def index
    @paid_services = @client.paid_services
  end
  
  def new
    @paid_service = PaidService.new
  end
  
  def create
    @paid_service = @client.paid_services.new(paid_service_params)
    if @paid_service.save
      if @paid_service.amount > 0
        current_cash_box.incomes.create(:service => paid_service_params[:service_id], :client => @client.id, :amount => paid_service_params[:amount], :comment => "New service")
      end
      redirect_to client_path(@client.id)
    else
      render :new
    end
  end
  
  def edit
   
  end
  
  def update
    if @paid_service.update(:amount => (@paid_service.amount + paid_service_params[:amount].to_f))
      if @paid_service.amount > 0
        current_cash_box.incomes.create(:service => @paid_service.service.id, :client => @client.id, :amount => paid_service_params[:amount], :comment => "Доплата за услугу #{@paid_service.service.title}")
      end
      redirect_to client_path(@client.id)
    else
      render :edit
    end
  end
  
  private
  
  def paid_service_params
    params.require(:paid_service).permit(:service_id,:start_date,:end_date,:amount,:comment,:required_amount)
  end
  
  def set_client
    @client = Client.find(params[:client_id])
  end
  
  def set_paid_service
     @paid_service = PaidService.find(params[:id])
  end
end
