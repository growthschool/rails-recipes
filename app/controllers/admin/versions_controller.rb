class Admin::VersionsController < AdminController

  before_action :require_admin!

  def index
    @versions = PaperTrail::Version.order("id DESC").page(params[:page])
  end

  def undo
    @version = PaperTrail::Version.find(params[:version_id])
    @version.reify.save!
    redirect_to admin_versions_path
   end
end
