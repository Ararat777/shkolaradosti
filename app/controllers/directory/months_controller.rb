class Directory::MonthsController < DirectoriesController
  
  def index
    @months = Month.where(:year => Date.today.year).order(:number)
  end
  
  def show
    @month = Month.find(params[:id])
    @exceptional_days = @month.exceptional_days
  end
  
  def create
  end
end
