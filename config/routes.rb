Rails.application.routes.draw do
  get '/', to: 'static#home'
  get '/secret', to: 'static#secret'

  resources :users
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
