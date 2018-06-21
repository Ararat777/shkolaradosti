class Directory::UsersController < DirectoriesController
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to directory_users_path
    else
      redirect_to directory_users_path
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to directory_users_path
    else
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to directory_users_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:phone,:branch_id,:role_id)
  end
  
end
