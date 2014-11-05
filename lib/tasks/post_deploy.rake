desc 'Run all deployment rake tasks'
task :post_deploy => [
  'maintenance:start',
  'deploy:chef_client',
  'deploy:migrate_db',
  'deploy:precompile_assets',
  'deploy:restart_app',
  'maintenance:end',
  'deploy:tell_newrelic'
]
