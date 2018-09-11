class TransfersController < ApplicationController
  
  def index
    @transfers = current_cash_box.current_cash_box_session.transfers
  end
  
  def new
    @transfer = Transfer.new
  end
  
  def show
  end
  
  def create
    @transfer = Transfer.new(transfers_params)
    if @transfer.save
      redirect_to cashbox_path
    else
      flash[:error] = @transfer.errors.full_messages
      render :new
    end
  end
  
  def confirme
    Transfer.find(params[:id]).exec_transfer
    redirect_to cashbox_path
  end
  
  private
  
  def filter_query(query)
    @filter_params = {}
    query.each do |k,v|
      @filter_params[k.to_sym] = v
      @transfers = @transfers.public_send(k,v)
    end
  end
  
  def transfers_params
    params.require(:transfer).permit(:from_cashbox,:to_cashbox,:amount,:comment)
  end
end
