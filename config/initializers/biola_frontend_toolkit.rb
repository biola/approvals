BiolaFrontendToolkit.configure do |config|
  config.app_name = Settings.app.name
  config.relative_root = Settings.app.relative_url_root
  config.app_links = [
    {title: Settings.app.name, url: Settings.app.relative_url_root, icon: 'home'},
    {title: 'Timecard', url: 'http://timecard.biola.edu', icon: 'calendar'},
    {title: 'Gmail', url: 'http://mail.biola.edu', icon: 'envelope-o'},
    {title: 'Forms', url: 'http://forms.biola.edu', icon: 'check-square-o'},
  ]
  config.profile_links = [
    {title: 'My Profile', url: (Settings.app.full_url.to_s + '/my_profile'), icon: 'user'}
  ]
end
