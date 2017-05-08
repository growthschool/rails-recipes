class AdminController < ApplicationController
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :require_admin!

  layout "admin"

  protected

  def require_admin!
    if current_user.role != "admin"
      flash[:alert] = "您的權限不足"
      redirect_to root_path
    end
  end

end
