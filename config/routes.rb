Rails.application.routes.draw do
  root 'sessions#index'
  
  resources :matches

  get '/session' => 'sessions#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
end
