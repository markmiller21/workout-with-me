Rails.application.routes.draw do
  root 'sessions#index'

  resources :matches
  resources :activities

  get '/session' => 'sessions#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
end
