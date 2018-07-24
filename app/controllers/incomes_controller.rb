class IncomesController < ApplicationController
  include OperationActions
  
  private
  
  def incomes_params
    params.require(:income).permit(:title,:amount,:comment,:client_id,:acceptor,:paid_service_id)
  end
end
