class Admin::EventRegistrationsController < ApplicationController
  before_action :find_event

  def index
    @registrations = @event.registrations.includes(:ticket).order("id DESC")
  end


  protected

  def find_event
    @event = Event.find_by_friendly_id!(params[:event_id])
  end

end
