class ClientsController < ApplicationController
  before_action :set_client, only: [:show,:update]
  
  def index
    @clients = current_branch.clients
  end
  
  def show
    @paid_services = @client.paid_services
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
  
  private
  
  def client_params
    params.require(:client).permit(:name,:age,:allergy,:comment)
  end
  
  def set_client
    @client = Client.find(params[:id])
  end
end
