class ClientsController < ApplicationController
  before_action :set_client, only: [:show,:update,:handle_visit,:remove_food_balance]
  
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
    @food = @client.food
  end
  
  def new
    @parent = Parent.new
    @client = Client.new
  end
  
  def create
    @client = current_branch.clients.new(client_params)
    if @client.save
      redirect_to client_path(@client.id)
    else
      render :new
    end
  end
  
  def handle_visit
    
    unless @client.visited_days.find_by(:day => Date.today)
      @client.visited_days.create(:day => Date.today)
      if food = @client.food
        food.days_count.current_count_days -= 1
        food.days_count.save
      end
    end
    
    respond_to do |format|
      format.js {}
    end
  end
  
  def remove_food_balance
    food = @client.paid_services.find(params[:service_id])
    amount = food.remove_food_balance
    food.update(:status => false)
    current_cash_box.make_consumption(:title => "Списание баланса питания", :amount => amount, :comment => "Списание #{amount}грн с баланса питания")
    redirect_to client_path(@client.id)
  end
  
  private
  
  def client_params
    params.require(:client).permit(:name,:age,:allergy,:comment,parent_attributes: [:father_name,:father_adress,:father_work_adress,:father_phone,:father_additional_phone,:father_birthdate,:father_email,:mother_name,:mother_adress,:mother_work_adress,:mother_phone,:mother_additional_phone,:mother_birthdate,:mother_email])
  end
  
  def set_client
    @client = Client.find(params[:id])
  end
end
