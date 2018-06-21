class ConsumptionsController < ApplicationController
  def index
    @consumptions = current_cash_box.consumptions
    if params[:q]
      filter_query(params[:q])
    end
  end
  
  def new
    @consumption = current_cash_box.consumptions.new
  end
  
  def create
    @consumption = current_cash_box.consumptions.new(consumption_params)
    if @consumption.save
      redirect_to cashbox_path
    else
    end
  end
  
  private
  
  def filter_query(query)
    if query[:client]
      @consumptions = @consumptions.where(:client => query[:client])
    end
    if query[:start_date]
      @consumptions = @consumptions.where("created_at >= :start_date", start_date: query[:start_date])
    end
    if query[:end_date]
      @consumptions = @consumptions.where("created_at <= :end_date", end_date: query[:end_date].to_date.end_of_day.utc)
    end
  end
  
  def consumption_params
    params.require(:consumption).permit(:consumption_title,:amount,:comment)
  end
end
