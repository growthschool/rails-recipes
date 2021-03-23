class Admin::EventsController < AdminController

  def index
    @events = Event.rank(:row_order).all
  end

  def show
    @event = Event.find_by_friendly_id!(params[:id])
  end

  def new
    @event = Event.new
    @event.tickets.build
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to admin_events_path
    else
      render "new"
    end
  end

  def edit
    @event = Event.find_by_friendly_id!(params[:id])
    @event.tickets.build if @event.tickets.empty?
  end

  def update
    @event = Event.find_by_friendly_id!(params[:id])

    if @event.update(event_params)
      redirect_to admin_events_path
    else
      render "edit"
    end
  end

  def destroy
    @event = Event.find_by_friendly_id!(params[:id])
    @event.destroy

    redirect_to admin_events_path
  end

  def bulk_update
    total = 0
    Array(params[:ids]).each do |event_id|
      event = Event.find(event_id)
      if params[:commit] == I18n.t(:bulk_update)
        event.status = params[:event_status]
          if event.save
            total += 1
          end
      elsif params[:commit] == I18n.t(:bulk_delete)
            event.destroy
            total += 1
      end
    end
    flash[:alert] = "刪除完成#{total}筆"
    redirect_to admin_events_path
  end

  def reorder
    @event = Event.find_by_friendly_id!(params[:id])
    @event.row_order_position = params[:position]
    @event.save!
    respond_to do |format|
      format.html { redirect_to admin_events_path }
      format.json { render :json => { :message => "ok" } }
    end
  end

  protected

  def event_params
    params.require(:event).permit(:name, :logo, :remove_logo, :description, :friendly_id, :status, :category_id, :tickets_attributes => [:id, :name, :description, :price, :_destroy])
  end

end
