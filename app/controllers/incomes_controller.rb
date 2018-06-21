class IncomesController < ApplicationController
  
  def index
    @incomes = current_cash_box.incomes
    if params[:q]
      filter_query(params[:q])
    end
  end
  
  def new
    @income = current_cash_box.incomes.new
  end
  
  def show
    
  end
  
  def create
    @income = current_cash_box.incomes.new(income_params)
    if @income.save
      redirect_to cashbox_path
    else
    end
  end
  
  def download_pdf
    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text 'Hello World'

        send_data pdf.render,disposition: :inline        
      end
    end
  end
  
  private
  
  def filter_query(query)
    if query[:client]
      @incomes = @incomes.where(:client => query[:client])
    end
    if query[:start_date]
      @incomes = @incomes.where("created_at >= :start_date", start_date: query[:start_date])
    end
    if query[:end_date]
      @incomes = @incomes.where("created_at <= :end_date", end_date: query[:end_date].to_date.end_of_day.utc)
    end
  end
  
  def income_params
    params.require(:income).permit(:income_title,:amount,:comment,:client,:acceptor)
  end
end
