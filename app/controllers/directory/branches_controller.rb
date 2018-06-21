class Directory::BranchesController < DirectoriesController
  before_action :set_branch,only: [:show,:edit,:update,:destroy]
  
  def index
    @branches = Branch.all
  end
  
  def new
    @branch = Branch.new
  end
  
  def show
   @services = @branch.services
  end
  
  def create
    @branch = Branch.new(branch_params)
    if @branch.save
      redirect_to directory_branches_path
    else
    end
  end
  
  def edit
   
  end
  
  def update
   
    if @branch.update(branch_params)
      redirect_to directory_branch_path(@branch.id)
    else
    end
  end
  
  private
  
  def set_branch
    @branch = Branch.find(params[:id])
  end
  
  def branch_params
    params.require(:branch).permit(:title, :adress)
  end
  
end
