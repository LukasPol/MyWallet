Rails.application.routes.draw do
  resources :tradings
  root to: 'home#index'
  get 'home/index'
  devise_for :users
end
