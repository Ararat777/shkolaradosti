class FoodsController < ApplicationController
  before_action :set_client
  
  def new
    @food = Food.new
  end
  
  def create
    
    @food = @client.foods.new(food_params)
    if @food.save
      current_cash_box.incomes.create(:service => Service.find_by(:title => "Питание").id , :client => @client.id, :amount => food_params[:amount], :comment => "Оплата за питание")
      redirect_to client_path(@client.id)
    else
    end
  end
  
  private
  
  def set_client
    @client = Client.find(params[:client_id])
  end
  
  def food_params
    params.require(:food).permit(:amount,:paid_days, :comment)
  end
end
