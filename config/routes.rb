Rails.application.routes.draw do
  root 'sessions#index'

  resources :matches
  resources :activities
  resources :users

  get '/session' => 'sessions#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/auth/:provider/callback', :to => 'sessions#create'
	get '/auth/failure', :to => 'sessions#failure'
end
