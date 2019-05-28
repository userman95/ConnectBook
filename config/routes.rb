Rails.application.routes.draw do
  get 'users/index'
  post 'users/send_request' => 'users#send_request'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: "users#index"

end
