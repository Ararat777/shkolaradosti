class DirectoriesController < ApplicationController
  before_action :authenticate_admin
  
  private
  
  def authenticate_admin
    unless current_user.admin?
      flash[:error] = "У вас нет доступа!"
      redirect_to root_url
    end
  end
end
