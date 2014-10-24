Rails.application.routes.draw do

  resources :proposals, path: '' do
    resources :comments
    resources :approvals do
      get :decide, on: :member
    end
  end

  # this is just a convenience to create a named route to rack-cas' logout
  get '/logout' => -> env { [200, { 'Content-Type' => 'text/html' }, ['Rack::CAS should have caught this']] }, as: :logout

  root to: "proposals#index"
end
