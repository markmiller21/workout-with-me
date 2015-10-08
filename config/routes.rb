Rails.application.routes.draw do
  root 'sessions#index'
  
  resources :matches

  resources :matches

  get '/session' => 'sessions#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
end
