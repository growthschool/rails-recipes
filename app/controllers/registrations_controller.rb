class RegistrationsController < ApplicationController

  before_action :find_event

  def new
  end

  def create
    @registration = @event.registrations.new(registration_params)
    @registration.ticket = @event.tickets.find(params[:registration][:ticket_id])
    @registration.status = "pending"
    @registration.user = current_user
    @registration.current_step = 1
    if @registration.save
      redirect_to step2_event_registration_path(@event, @registration)
    else
      flash.now[:alert] = @registration.errors[:base].join("、")
      render "new"
    end
  end

   def show
     @registration = @event.registrations.find_by_uuid(params[:id])
   end

   def step1
     @registration = @event.registrations.find_by_uuid(params[:id])
   end

   def step1_update
     @registration = @event.registrations.find_by_uuid(params[:id])
     @registration.current_step = 1
     if @registration.update(registration_params)
       redirect_to step2_event_registration_path(@event, @registration)
     else
       render "step1"
     end
   end

   def step2
     @registration = @event.registrations.find_by_uuid(params[:id])
   end

   def step2_update
     @registration = @event.registrations.find_by_uuid(params[:id])
     @registration.current_step = 2
     if @registration.update(registration_params)
        redirect_to step3_event_registration_path(@event,@registration)
     else
       render "step2"
      end
    end

    def step3
      @registration = @event.registrations.find_by_uuid(params[:id])
    end

    def step3_update
      @registration = @event.registrations.find_by_uuid(params[:id])
      @registration.current_step = 3
      @registration.status = "confirmed"
       if @registration.update(registration_params)
         flash[:notice] = "报名成功"

         NotificationMailer.confirmed_registration(@registration).deliver_later
         
         redirect_to event_registration_path(@event, @registration)
       else
         render "step3"
       end
     end

   protected

   def registration_params
     params.require(:registration).permit(:ticket_id, :name, :email, :cellphone, :website, :bio)
   end

   def find_event
     @event = Event.find_by_friendly_id(params[:event_id])
   end

end
