Rails.application.routes.draw do

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  devise_for :devices
  devise_for :users,
             :controllers => { :sessions => 'api/sessions', registrations: 'api/registrations'}
  get :new_session, to: 'device_sessions#new_session'
  resources :devices

  get :device_settings, to: 'devices#device_settings'

  resources :reports, only: :create
  match 'reports/show' => 'reports#show', :via => :get
  resources :charts, only: :show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
