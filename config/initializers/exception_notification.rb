if defined? ::ExceptionNotifier
  Approvals::Application.config.middleware.use ExceptionNotification::Rack,
    email: {
      email_prefix: '[approvals] ',
      sender_address: Settings.email.from,
      exception_recipients: Settings.exceptions.mail_to
    }
end
