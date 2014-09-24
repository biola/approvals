Turnout.configure do |config|
  config.named_maintenance_file_paths.merge! server: '/tmp/turnout.yml'
end
