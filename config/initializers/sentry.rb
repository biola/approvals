if defined? Raven
  Raven.configure do |config|
    config.dsn = Settings.sentry.url
  end
end
