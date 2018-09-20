class InventoryTransfersController < ApplicationController
  
  def index
  end
  
  def new
    @transfer = InventoryTransfer.new
  end

  
  def create
    @transfer = InventoryTransfer.new(transfer_params)
    
    if @transfer.save
      @transfer.inventory_categories << [
        @transfer.sender.inventory_categories.find_by(:title => @transfer.inventory_category_title),
        @transfer.reciever.inventory_categories.find_by(:title => @transfer.inventory_category_title)
        ]
      redirect_to inventory_categories_path
    else
      flash[:error] = @transfer.errors
      render :new
    end
  end
  
  def confirme
    @transfer = InventoryTransfer.find(params[:id]).exec_transfer
    redirect_to inventory_categories_path
  end
  
  private
  
  def transfer_params
    params.require(:inventory_transfer).permit(:from_branch,:to_branch,:inventory_category_title,:size,:comment)
  end
  
end
