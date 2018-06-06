class EncashmentsController < ApplicationController
  
  def index
    @encashments = current_cash_box.encashments
    
    if params[:q]
      filter_query(params[:q])
    end
  end
  
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
  
  def filter_query(query)
    if query[:client]
      @encashments = @encashments.where(:client => query[:client])
    end
    if query[:start_date]
      @encashments = @encashments.where("created_at >= :start_date", start_date: query[:start_date])
    end
    if query[:end_date]
      @encashments = @encashments.where("created_at <= :end_date", end_date: query[:end_date].to_date.end_of_day.utc)
    end
  end
  
  def encashment_params
    params.require(:encashment).permit(:amount,:comment)
  end
end
