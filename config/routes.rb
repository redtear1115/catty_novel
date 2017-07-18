Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauths' }

  authenticate :user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  # account controller
  namespace :account do
    get 'profile',    to: 'profile'
    get 'disconnect', to: 'disconnect'
  end

  # collections controller
  resources :collections, only: [:index, :create, :destroy]
  get 'read',       to: 'collections#read'
  get 'end_page',   to: 'collections#end_page'

  # novels controller
  resources :novels, only: [:index, :new, :create]
  get 'search', to: 'novels#search'
  post 'search_result', to: 'novels#search_result'


  # api controller
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'update_last_read_chapter', to: 'update_last_read_chapter'
      get 'auth_info', to: 'auth_info'
    end
  end

  # Keep root at the bottom
  root to: 'collections#index'
end
