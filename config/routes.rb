Rails.application.routes.draw do
  get 'users/index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: "users#index"

end
