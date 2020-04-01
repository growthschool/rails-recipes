class Admin::EventRegistrationsController < ApplicationController

  before_action :find_event

  def index
    @registrations = @event.registrations.includes(:ticket).order("id DESC")
  end

  def new
    @registration = Registration.new
  end

  def create
    @registration = @event.registrations.new(registration_params)
    @registration.ticket = @event.tickets.find(params[:registration][:ticket_id])
    @registration.status = "pending"
    @registration.user = current_user

    if @registration.save
      redirect_to admin_event_registrations_path(@event)
    else
      render "new"
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

  def registration_params
    params.require(:registration).permit(:status, :ticket_id, :name, :email, :cellphone, :website, :bio)
  end
end
