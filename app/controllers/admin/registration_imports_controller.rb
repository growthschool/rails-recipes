class Admin::RegistrationImportsController < ApplicationController
  def create
    @import = @event.registration_imports.new(registration_import_params)
    @import.status
    @import.user = current_user

    if @import.save
      ImportWorkerJob.perform_later(@import.id)
      flash[:notice] = "汇入已在背景执行，请稍候再来看结果"
    end

    redirect_to admin_event_registration_imports_path(@event)
  end
end
