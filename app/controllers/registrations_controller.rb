class RegistrationsController < ApplicationController

  before_action :find_event

  def new
  end

  def create
    @registration = @event.registrations.new(registration_params)
    @registration.ticket = @event.tickets.find(params[:registration][:ticket_id])
    @registration.status = "confirmed"
    @registration.user = current_user

    if @registration.save
      redirect_to event_registration_path(@event, @registration)
    else
      render "new"
    end
  end

   def show
     @registration = @event.registrations.find_by_uuid(params[:id])
   end

   protected

   def registration_params
     params.require(:registration).permit(:ticket_id, :name, :email, :cellphone, :website, :bio)
   end

   def find_event
     @event = Event.find_by_friendly_id(params[:event_id])
   end

end
