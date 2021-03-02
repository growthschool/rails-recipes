module EventsHelper

  def display_event_status(event)
    case event.status
      when "draft"
        "草稿"
      else
        ""
    end
  end

end
