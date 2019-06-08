Rails.application.routes.draw do
  get 'users/index'
  get 'users/pending_requests'
  get 'posts/index'
  post 'posts/index' => 'posts#create'
  post 'users/send_request' => 'users#send_request'
  get '/users/:id' => 'users#show', :as => :user
  post '/users/:id' => 'posts#create'
  get '/post/:id' , to: 'likes#create'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :posts, only: [:create,:new,:index,:edit]
  resources :likes, only: [:create]
  root to: "users#index"

end
