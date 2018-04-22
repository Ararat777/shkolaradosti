class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :current_cash_box,:current_branch
  
  def current_cash_box
    if user_signed_in?
      @current_cash_box ||= current_branch.cash_box
    end
  end
  
  def current_branch
    if user_signed_in?
      @current_branch ||= current_user.branch
    end
  end
end
