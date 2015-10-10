Rails.application.routes.draw do
  root 'sessions#index'

  resources :matches
  resources :activities
  resources :users
  resources :users do
    resources :matches
  end

  get '/session' => 'sessions#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'session#destroy'
end
