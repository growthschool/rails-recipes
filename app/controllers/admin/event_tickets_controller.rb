class Admin::EventTicketsController < ApplicationController
  before_action :find_event

  def index
    @tickets = @event.tickets
  end


  protected

  def find_event
    @event = Event.find_by_friendly_id!(params[:event_id])
  end
end
