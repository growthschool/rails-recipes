module EventsHelper
  def display_event_status(event)
    case event.status
    when "draft"
      "草稿"
    when "public"
      "公开"
    else
      "私密"
    end
  end
end
