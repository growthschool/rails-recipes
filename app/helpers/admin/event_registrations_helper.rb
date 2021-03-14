module Admin::EventRegistrationsHelper

  def registration_filters(options)
    params.permit(:status, :ticket_id).merge(options)
  end

end
