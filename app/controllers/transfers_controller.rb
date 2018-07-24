class TransfersController < ApplicationController
  include OperationActions
  
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
