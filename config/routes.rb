Rails.application.routes.draw do
  root 'sessions#index'
  
  resources :matches

  get 'possible_matches/:id' => 'possible_matches#show'

  get '/session' => 'sessions#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
end
