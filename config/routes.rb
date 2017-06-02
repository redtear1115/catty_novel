Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  # home controller
  get 'index',    to: 'home#index'
  get 'read',     to: 'home#read'
  get 'end_page', to: 'home#end_page'

  # collections controller
  resources :collections, only: [:create, :destroy]

  # novels controller
  resources :novels, only: [:index, :new, :create]
  get 'search', to: 'novels#search'
  post 'search_result', to: 'novels#search_result'

  # Keep root at the bottom
  root to: 'home#index'
end
