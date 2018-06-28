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
    @income = Income.find(params[:id])
  end
  
  def create
    if @income = current_cash_box.make_income(income_params)
      redirect_to income_path(@income.id)
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
    query.each do |k,v|
      @incomes = @incomes.public_send(k,v)
    end
  end
  
  def income_params
    params.require(:income).permit(:title,:amount,:comment,:client_id,:acceptor)
  end
end
