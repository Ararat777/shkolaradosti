class ClientsController < ApplicationController
  before_action :set_client, only: [:show,:create,:update]
  
  def index
    @clients = current_branch.clients
  end
  
  def show
    @paid_services = @client.paid_services
  end
  
  def new
  end
  
  def create
  end
  
  private
  
  def set_client
    @client = Client.find(params[:id])
  end
end
