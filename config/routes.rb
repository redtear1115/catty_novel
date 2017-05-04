Rails.application.routes.default_url_options = Secret.default_url_options
Rails.application.routes.draw do  
  devise_for :users
  
  authenticate :user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
  
  # home controller
  get 'read', to: 'home#read'
  get 'end_page', to: 'home#end_page'
  get 'add_to_collection', to: 'home#add_to_collection'
  get 'remove_collection', to: 'home#remove_collection'
  
  # novel controller
  resources :novels
  get 'search', to: 'novels#search'
  post 'search_result', to: 'novels#search_result'
  
  # Keep root at the bottom
  root to: 'home#index'
end
