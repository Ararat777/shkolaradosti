class Directory::ServicesController < DirectoriesController
  before_action :set_branch
  
  def new
    @service = @branch.services.new
  end
  
  def create
    @service = @branch.services.new(service_params)
    if @service.save
      redirect_to directory_branch_path(@branch.id)
    else
    end
  end
  
  def edit
    @service = Service.find(params[:id])
  end
  
  def update
    @service = Service.find(params[:id])
    if @service.update(service_params)
      redirect_to directory_branch_path(@branch.id)
    else
    end
  end
  
  private
  
  def service_params
    params.require(:service).permit(:title,:price,:active,:countable,:comment)
  end
  
  def set_branch
    @branch = Branch.find(params[:branch_id])
  end
end
