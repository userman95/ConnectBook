Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'users/index'
  get 'users/pending_requests'
  get 'posts/index'
  post 'posts/index' => 'posts#create'
  get '/users/:id' => 'users#show', :as => :user
  post '/users/:id' => 'posts#create'
  get 'posts/index' => 'comments#comments_of_post'

  resources :posts, only: %i[index create destroy show] do
    resources :comments, only: [:index]
  end
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :index, :destroy, :comments_of_post]

  root to: "users#index"

end
