Rails.application.routes.draw do
  get '/', to: 'static#home'
  get '/home_club', to: 'static#home_club'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
end
