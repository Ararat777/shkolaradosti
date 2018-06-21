class Directory::ExceptionalDaysController < DirectoriesController
  def create
    @month = Month.find(params[:month_id])
    @exceptional_day = @month.exceptional_days.new(days_params)
    if @exceptional_day.save
      redirect_to directory_month_path(@month.id)
    else
    end
  end
  
  def destroy
    @month = Month.find(params[:month_id])
    @exceptional_day = ExceptionalDay.find(params[:id])
    @exceptional_day.destroy
    redirect_to directory_month_path(@month.id)
  end
  
  private
  
  def days_params
    params.require(:exceptional_day).permit(:day,:is_holiday)
  end
end
