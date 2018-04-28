class ConsumptionsController < ApplicationController
  def new
    @consumption = Consumption.new
  end
  
  def create
    @consumption = current_cash_box.consumptions.new(consumption_params)
    if @consumption.save
      redirect_to cashbox_path
    else
    end
  end
  
  private
  
  def consumption_params
    params.require(:consumption).permit(:title,:amount,:comment)
  end
end
