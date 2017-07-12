Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauths' }

  authenticate :user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  # Omniauth
  # devise_scope :user do
  #   get 'users/auth/:provider/callback', to: 'omniauths#create'
  # end

  # home controller
  get 'index',      to: 'home#index'
  get 'read',       to: 'home#read'
  get 'end_page',   to: 'home#end_page'
  get 'account',    to: 'home#account'
  get 'disconnect', to: 'home#disconnect'

  # collections controller
  resources :collections, only: [:create, :destroy]

  # novels controller
  resources :novels, only: [:index, :new, :create]
  get 'search', to: 'novels#search'
  post 'search_result', to: 'novels#search_result'
  # omniauth controller
  get 'auth_info', to: 'home#auth_info', defaults: { format: :json }

  # api controller
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'setup_chp_idx', to: 'setup_chp_idx'
    end
  end
  # Keep root at the bottom
  root to: 'home#index'
end
