class TransfersController < ApplicationController
  
  def index
    @transfers = current_cash_box.transfers
    if params[:q]
      filter_query(params[:q])
    end
  end
  
  def new
    @transfer = Transfer.new
  end
  
  def show
    @transfer = Transfer.find(params[:id])
  end
  
  def create
    
    if @transfer = current_cash_box.make_transfer(transfer_params)
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
  
  def filter_query(query)
    if query[:client]
      @transfers = @transfers.where(:client => query[:client])
    end
    if query[:start_date]
      @transfers = @transfers.where("created_at >= :start_date", start_date: query[:start_date])
    end
    if query[:end_date]
      @transfers = @transfers.where("created_at <= :end_date", end_date: query[:end_date].to_date.end_of_day.utc)
    end
  end
  
  def transfer_params
    params.require(:transfer).permit(:from_cashbox,:to_cashbox,:amount,:comment)
  end
end
