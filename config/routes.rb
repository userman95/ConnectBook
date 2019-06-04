Rails.application.routes.draw do
  get 'users/index'
  get 'users/pending_requests'
  post 'users/send_request' => 'users#send_request'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: "users#index"

end
