Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'welcome' => 'events#welcome'
  root "events#welcome"
  
  resources :users do
    member do
      get :activate
    end
    resources :events, except:[:new, :index] do
      resources :comments, only: [:destroy, :update, :create]
    end
    resources :movie_interests, except: [:index, :show]
    resources :ratings
    resources :commitments, only: [:destroy, :update, :create]
  end
  resources :friendships, only: [:destroy, :create] 
  resources :user_sessions, only: [:destroy, :new, :create]

  get 'all_events' => 'events#all_events', :as => :events
  # get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end