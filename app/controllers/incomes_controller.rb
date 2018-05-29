class IncomesController < ApplicationController
  
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
  
  private
  
  def income_params
    params.require(:income).permit(:title,:amount,:comment)
  end
end
