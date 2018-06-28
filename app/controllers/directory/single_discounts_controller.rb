class Directory::SingleDiscountsController < DirectoriesController
  
  def index
    @discounts = SingleDiscount.all
  end
  
  def new
    @discount = SingleDiscount.new
  end
  
  def create
    @discount = SingleDiscount.new(discount_params)
    if @discount.save
      redirect_to directory_single_discounts_path
    else
    end
  end
  
  def edit
    @discount = SingleDiscount.find(params[:id])
  end
  
  def update
    @discount = SingleDiscount.find(params[:id])
    if @discount.update(discount_params)
      redirect_to directory_single_discounts_path
    else
    end
  end
  
  def destroy
    @discount = SingleDiscount.find(params[:id])
    @discount.destroy
    redirect_to directory_single_discounts_path
  end
  
  private
  
  def discount_params
    params.require(:single_discount).permit(:title,:discount_size,:count,:fixed,:branch_id,:comment)
  end
end
