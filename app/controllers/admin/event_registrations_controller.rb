class Admin::EventRegistrationsController < AdminController

  before_action :find_event

  def index
    @registrations = @event.registrations.order("id DESC").page(params[:page])

    if params[:status] && Registration::STATUS.include?(params[:status])
      @registrations = @registrations.by_status(params[:status])
    end

  end

  def destroy
    @registration = @event.registrations.find_by_uuid(params[:id])
    @registration.destroy

    redirect_to admin_event_registrations_path(@event)
  end

  protected

  def find_event
    @event = Event.find_by_friendly_id!(params[:event_id])
  end

  protected

  def registration_params
    params.require(:registration).permit(:status, :ticket_id, :name, :email, :cellphone, :website, :bio)
  end

end
