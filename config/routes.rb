Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :posts, only: %i[index create destroy show] do
    resources :comments, only: [:index, :create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :users
  resources :friend_requests, only: [:create, :index, :destroy]
  resources :comments, only: [:create, :index, :destroy]
  resources :friendships, only: [:create, :index, :destroy]
  root to: "users#index"

end
