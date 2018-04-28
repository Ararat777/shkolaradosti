class TransfersController < ApplicationController
  
  def new
    @transfer = Transfer.new
  end
  
  def create
    @transfer = Transfer.new(transfer_params)
    if @transfer.save
      redirect_to cashbox_path
    else
      render :new
    end
  end
  
  def confirme
    Transfer.find(params[:id]).exec_transfer
    redirect_to cashbox_path
  end
  
  private
  
  def transfer_params
    params.require(:transfer).permit(:from_cashbox,:to_cashbox,:amount,:comment)
  end
end
