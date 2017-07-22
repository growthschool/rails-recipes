class Admin::EventRegistrationsController < AdminController

  before_action :find_event

  def index
    @q = @event.registrations.ransack(params[:q])
    @registrations = @q.result.includes(:ticket).order("id DESC").page(params[:page])
     if params[:registration_id].present?
       @registrations = @registrations.where( :id => params[:registration_id].split(","))
     end
    if Array(params[:statuses]).any?
      @registrations = @registrations.by_status(params[:statuses])
    end

     if Array(params[:ticket_ids]).any?
      @registrations = @registrations.by_ticket(params[:ticket_ids])
     end

     if params[:start_on].present?
      @registrations = @registrations.where( "created_at >= ?", Date.parse(params[:start_on]).beginning_of_day )
     end

     if params[:end_on].present?
       @registrations = @registrations.where( "created_at <= ?", Date.parse(params[:end_on]).end_of_day )
     end

      if params[:status].present? && Registration::STATUS.include?(params[:status])
       @registrations = @registrations.by_status(params[:status])
      end

      if params[:ticket_id].present?
       @registrations = @registrations.by_ticket(params[:ticket_id])
      end
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
