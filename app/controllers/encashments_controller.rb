class EncashmentsController < ApplicationController
  def new
    @encashment = Encashment.new
  end
  
  def create
    @encashment = current_cash_box.encashments.new(encashment_params)
    if @encashment.save
      redirect_to cashbox_path
    else
    end
  end
  
  private
  
  def encashment_params
    params.require(:encashment).permit(:amount,:comment)
  end
end
