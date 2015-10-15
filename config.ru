# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

map ENV['PUMA_RELATIVE_URL_ROOT'] || '/' do
  run Rails.application
end
