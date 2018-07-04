class Directory::DiscountsController < DirectoriesController
  
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
  
  def destroy
    @discount = Discount.find(params[:id])
    @discount.destroy
    redirect_to directory_discounts_path
  end
  
  def find_clients
    @discount = Discount.find(params[:id])
    @clients = Client.find_client(params[:q][:name])
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
  
  def remove_discount_client
    @discount = Discount.find(params[:id])
    @client = Client.find(params[:client_id])
    @client.update(:discount_id => nil)
    redirect_to directory_discount_path(@discount.id)
  end
  
  private
  
  def discount_params
    params.require(:discount).permit(:title,:discount_size,:comment,:active)
  end
end
