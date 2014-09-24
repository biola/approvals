require 'rack-cas/session_store/rails/mongoid'
Approvals::Application.config.session_store :rack_cas_mongoid_store, key: '_approvals_session'
