class Admin::UserProfilesController < AdminController

  before_action :find_user_and_profile
  before_action :require_admin!


  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  protected

  def find_user_and_profile
    @user = User.find(params[:user_id])
    # 因为新建的用户并没有profile，所以这里先检查是否有 @user.profile，如果没有的话就用@user.create_profile新建进数据库
    @profile = @user.profile || @user.create_profile
  end

  def profile_params
    params.require(:profile).permit(:legal_name, :birthday, :location , :education, :occupation,:bio,:specialty)
  end
end
