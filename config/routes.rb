Rails.application.routes.draw do


  root "users#index"
  
  resources :users do
    resources :events
  end
  resources :friendships 
  resources :user_sessions, only: [:destroy, :new, :create]


  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end
