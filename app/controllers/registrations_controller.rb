class RegistrationsController < ApplicationController
  def new
    @event = Event.find_by_friendly_id(params[:event_id])
  end

  def create
    @event = Event.find_by_friendly_id(params[:event_id])
    @registration = @event.registrations.new(registration_params)
    @registration.ticket = @event.tickets.find( params[:registration][:ticket_id] )
    @registration.status = "confirmed"
    @registration.user = current_user

    if @registration.save
      redirect_to event_registration_path(@event, @registration)
    else
      render "new"
    end
  end

  protected

  def registration_params
    params.require(:registration).permit(:ticket_id, :name, :email, :cellphone, :website, :bio)
  end

end
