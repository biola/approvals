Rails.application.routes.draw do

  resources :approvals do
    resources :comments
  end



  # this is just a convenience to create a named route to rack-cas' logout
  get '/logout' => -> env { [200, { 'Content-Type' => 'text/html' }, ['Rack::CAS should have caught this']] }, as: :logout

  root to: "approvals#index"
end
