class ClientsController < ApplicationController
  before_action :set_client, only: [:show,:update,:handle_visit,:remove_countable_service_balance,:edit]
  
  def index
    
    if params[:q]
      @clients = current_branch.clients.where("name LIKE ?", "%#{params[:q][:name]}%")
    else
      @clients = current_branch.clients
    end
    
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
  
  def show
    @paid_services = @client.paid_services
    @parent = @client.parent
  end
  
  def new
    @client = Client.new
    @client.build_parent
  end
  
  def create
    @client = current_branch.clients.new(client_params)
    if @client.save
      redirect_to client_path(@client.id)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      redirect_to client_path(@client.id)
    else
      render :edit
    end
  end
  
  def handle_visit
    @client.handle_visit
    respond_to do |format|
      format.js {}
    end
  end
  
  def remove_countable_service_balance
    @paid_service = @client.paid_services.find(params[:service_id])
    
    @paid_service.remove_countable_balance(current_cash_box,{:title => "Списание баланса", :amount => @paid_service.countable_balance, :comment => "Списание #{@paid_service.countable_balance}грн с баланса услуги #{@paid_service.title}"})
    
    redirect_to client_path(@client.id)
  end
  
  def find_client
    @clients = Client.find_client(params[:client_name])
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def client_params
    params.require(:client).permit(:name,:age,:allergy,:comment,parent_attributes: [:father_name,:father_adress,:father_work_adress,:father_phone,:father_additional_phone,:father_birthdate,:father_email,:mother_name,:mother_adress,:mother_work_adress,:mother_phone,:mother_additional_phone,:mother_birthdate,:mother_email])
  end
  
  def set_client
    @client = Client.find(params[:id])
  end
end
