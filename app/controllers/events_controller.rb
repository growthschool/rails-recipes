class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find_by_friendly_id!(params[:id])
  end

end
