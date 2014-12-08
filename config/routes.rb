Rails.application.routes.draw do

  get 'friendships/create'

  get 'friendships/destroy'

  root "users#index"
  
  resources :users

end
