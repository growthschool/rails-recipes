class Admin::UsersController < ApplicationController
  def index
    @users = User.includes(:groups).rank(:row_order).all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  def reorder
    @user = User.find(params[:id])
    @user.row_order_position = params[:position]
    @user.save!

    redirect_to admin_users_path
  end

  protected

  def user_params
    params.require(:user).permit(:email, :group_ids => [])
  end
end
