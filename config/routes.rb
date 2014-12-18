Rails.application.routes.draw do

  get 'welcome' => 'events#welcome'
  root "events#welcome"
  
  resources :users do
    resources :events do
      resources :comments, only: [:destroy, :update, :create]
    end
    resources :movie_interests
    resources :ratings, only:  [:show, :create, :destroy, :index]
    resources :commitments, only: [:destroy, :update, :create]
  end
  resources :friendships, only: [:destroy, :create] 
  resources :user_sessions, only: [:destroy, :new, :create]

  get 'all_events' => 'events#all_events', :as => :events
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end