Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # get 'users/index'
  # get 'users/pending_requests'
  # get 'posts/index'
  # post 'posts/index' => 'posts#create'
  # get '/users/:id' => 'users#show', :as => :user
  # post '/users/:id' => 'posts#create'
  post '/users/send_request/:id', to: 'users#send_request'
  
  resources :users
  resources :posts, only: [:create, :update, :index, :destroy]
  resources :likes, only: [:create, :destroy]

  root to: "users#index"

end
