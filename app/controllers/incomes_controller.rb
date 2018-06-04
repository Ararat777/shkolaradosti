class IncomesController < ApplicationController
  
  def index
    @incomes = Income.all
  end
  
  def new
    @income = Income.new
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
  
  def income_params
    params.require(:income).permit(:title,:amount,:comment,:client,:acceptor)
  end
end
