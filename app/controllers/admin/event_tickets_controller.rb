class Admin::EventTicketsController < AdminController
  before_action :find_event

  def index
    @tickets = @event.tickets
  end

  def new
    @ticket = @event.tickets.new
  end

  def create
    @ticket = @event.tickets.new(ticket_params)
    if @ticket.save
      redirect_to admin_event_ticket_path(@event)
    else
      render "new"
    end
  end

  def edit
    @ticket = @event.tickets.find(params[:id])
  end

  def update
    @ticket = @event.tickets.find(params[:id])
    if @ticket.update(ticket_params)
      redirect_to admin_event_tickets_path(@event)
    else
      render "edit"
    end
  end

  def destroy
    @ticket = @event.tickets.find(params[:id])
    @ticket.destroy

    redirect_to admin_event_tickets_path(@event)
  end

  protected

  def find_event
    @event = Event.find_by_friendly_id!(params[:event_id])
  end

  def ticket_params
    params.require(:ticket).permit(:name,:price, :description)
  end
  
end
