class ClientsController < ApplicationController
  before_action :set_client, only: [:show,:update,:handle_visit]
  
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
    @visited_clients = Client.joins(:visited_days).where(:visited_days => {day: Date.today})
  end
  
  def show
    @paid_services = @client.paid_services
    @foods = @client.foods
  end
  
  def new
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
    @client.visited_days.create(:day => Date.today)
    respond_to do |format|
      format.js {}
    end
  end
  
  private
  
  def client_params
    params.require(:client).permit(:name,:age,:allergy,:comment)
  end
  
  def set_client
    @client = Client.find(params[:id])
  end
end
