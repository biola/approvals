# Rack::CAS includes a railtie by default but we're loading it manually here
# because of initializer order issues with rails_config.

if Rails.env.test?
  require 'rack/fake_cas'
  # We use swap because FakeCAS is included in the middleware by a the RackCAS railtie by default
  Approvals::Application.config.middleware.swap Rack::FakeCAS, Rack::FakeCAS
else
  require 'rack/cas'
  require 'rack-cas/session_store/mongoid'

  extra_attributes = [:cn, :eduPersonNickname, :sn, :title, :department, :mail, :url, :eduPersonAffiliation, :eduPersonEntitlement, :employeeId]
  Approvals::Application.config.middleware.use Rack::CAS,
    server_url: Settings.cas.url,
    session_store: RackCAS::MongoidStore,
    extra_attributes_filter: extra_attributes
end
