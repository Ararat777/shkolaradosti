class InventoryCategoriesController < ApplicationController
  before_action :set_category,only: [:show,:edit,:update,:destroy]
  
  def index
    @inventory_categories = InventoryCategory.all
  end
  
  def new
    @inventory_category = InventoryCategory.new
  end
  
  def show
    @category_items = @inventory_category.items
  end
  
  def create
    @inventory_category = InventoryCategory.new(category_params)
    if @inventory_category.save
      redirect_to inventory_categories_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    @inventory_category.update(category_params)
    redirect_to inventory_categories_path
  end
  
  def destroy
  end
  
  private
  
  def set_category 
    @inventory_category = InventoryCategory.find(params[:id])
  end
  
  def category_params
    params.require(:inventory_category).permit(:title,:branch_id,:size)
  end
end
