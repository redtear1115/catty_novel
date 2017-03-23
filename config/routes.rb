Rails.application.routes.draw do
  require 'sidekiq/web'
  devise_for :users
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'read', to: 'home#read'
  root to: 'home#index'
end
