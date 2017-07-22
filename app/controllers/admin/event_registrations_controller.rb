class Admin::EventRegistrationsController < AdminController

  before_action :find_event

  def index
     @registrations = @event.registrations.includes(:ticket).order("id DESC")
  end

  def destroy
     @registration = @event.registrations.find_by_uuid(params[:id])
     @registration.destroy

     redirect_to admin_event_registrations_path(@event)
  end

  def new
    @registration = @event.registrations.new
  end

  def create
    @registration = @event.registrations.new(registration_params)
    @registration.ticket = @event.tickets.find(params[:registration][:ticket_id])
    @registration.status = "pending"
    @registration.user = current_user
    if @registration.save
      redirect_to admin_event_registration_path(@event, @registration)
    else
      flash.now[:alert] = @registration.errors[:base].join("、")
      render "new"
    end
  end


  def edit
    @registration = @event.registrations.find_by_uuid(params[:id])
  end

  def update
    @registration = @event.registrations.find_by_uuid(params[:id])
    @registration.status = "confirmed"
    if @registration.update(registration_params)
      redirect_to admin_event_registrations_path(@event,@registration)
    else
      render "edit"
    end
  end

  def show
    @registration = @event.registrations.find_by_uuid(params[:id])
  end


  protected

  def find_event
     @event = Event.find_by_friendly_id!(params[:event_id])
  end

  def registration_params
     params.require(:registration).permit(:status, :ticket_id,:name, :cellphone, :website, :bio,:email)
  end
end
