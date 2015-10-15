Rails.application.routes.draw do
  root 'sessions#index'

  resources :matches, only: [ :index, :show, :create]
  resources :activities, only: [ :index, :create, :destroy ]
  resources :users, except: :destroy
  resources :matches do
    resources :messages, only: [:index, :create]
  end

  get '/session' => 'sessions#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  post '/ratings' => 'ratings#create'

  get '/initiate_match' => 'matches#initiate_match', as: 'initiate_match'
  get '/users/:id/preferences/edit' => 'users#edit_preferences', as: 'edit_preferences'
  patch '/users/:id/preferences' => 'users#update_preferences'
end
