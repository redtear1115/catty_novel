Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'read', to: 'home#read'
  root to: 'home#index'
end
