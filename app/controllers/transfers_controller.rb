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
    exec_transfer(Transfer.find(params[:id]))
    redirect_to cashbox_path
  end
  
  private
  
  def exec_transfer(transfer)
    CashBox.where(id: [transfer.from_cashbox,transfer.to_cashbox]).each do |item|
      if item.id == transfer.from_cashbox
        item.cash -= transfer.amount
      else
        item.cash += transfer.amount
      end
      item.save
    end
    transfer.confirmed!
  end
  
  def transfer_params
    params.require(:transfer).permit(:from_cashbox,:to_cashbox,:amount,:comment)
  end
end
