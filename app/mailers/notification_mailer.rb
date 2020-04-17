class NotificationMailer < ApplicationMailer

  def confirmed_registration(registration)
    @registration = registration
    @event = registration.event

    mail( :to => @registration.email, :subject => I18n.t("notification.subject.confirmed_registration", :name => @event.name) )
  end

end
