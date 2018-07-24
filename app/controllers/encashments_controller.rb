class EncashmentsController < ApplicationController
  include OperationActions
  
  
  private
  
  
  def encashments_params
    params.require(:encashment).permit(:amount,:comment)
  end
end
