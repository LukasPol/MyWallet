require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  unauthenticated :user do
    root to: 'home#index', as: :unauthenticated_user_root
  end

  authenticated :user do
    root to: 'wallets#index', as: :authenticated_user_root
  end

  devise_for :users

  get 'home/index'

  resources :tradings, except: [:edit, :update]
  resources :wallets, only: [:index]
  resources :proceeds
end
