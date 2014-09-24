ActionMailer::Base.smtp_settings = {
  :address => Settings.email.smtp.server
}

ActionMailer::Base.default_url_options = {
  :host => Settings.app.host,
  :script_name => Settings.app.relative_url_root
}
