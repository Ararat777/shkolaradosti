class ConsumptionsController < ApplicationController
  include OperationActions
  
  private
  
  
  def consumptions_params
    params.require(:consumption).permit(:title,:amount,:comment)
  end
end
