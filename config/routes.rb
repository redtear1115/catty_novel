Rails.application.routes.draw do
  
  devise_for :users
  
  authenticate :user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
  
  get 'read', to: 'home#read'
  get 'add_to_collection', to: 'home#add_to_collection'
  get 'remove_collection', to: 'home#remove_collection'
  
  resources :novels
  
  get 'search', to: 'novels#search'
  post 'search_result', to: 'novels#search_result'
  
  # Keep root at the bottom
  root to: 'home#index'
  
end
