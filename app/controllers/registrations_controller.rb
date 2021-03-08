class RegistrationsController < ApplicationController
  def new
    @event = Event.find_by_friendly_id(params[:event_id])
  end
end
