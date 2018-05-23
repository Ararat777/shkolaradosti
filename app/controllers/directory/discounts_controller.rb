class Directory::DiscountsController < ApplicationController
  
  def index
    @discounts = Discount.all
  end
  
  def new
    @discount = Discount.new
  end
  
  def show
    @discount = Discount.find(params[:id])
  end
  
  def create
    @discount = Discount.new(discount_params)
    if @discount.save
      redirect_to directory_discounts_path
    else
    end
  end
  
  def edit
    @discount = Discount.find(params[:id])
  end
  
  def update
    @discount = Discount.find(params[:id])
    if @discount.update(discount_params)
      redirect_to directory_discounts_path
    else
    end
  end
  
  def find_clients
    @discount = Discount.find(params[:id])
    @clients = Client.where("name LIKE ?", "%#{params[:q][:name]}%")
    respond_to do |format|
      format.js {}
    end
  end
  
  def add_discount_client
    @discount = Discount.find(params[:id])
    @client = Client.find(params[:client_id])
    @client.update(:discount_id => @discount.id)
    respond_to do |format|
      format.js {}
    end
  end
  
  private
  
  def discount_params
    params.require(:discount).permit(:title,:percent,:comment,:active)
  end
end
