Rails.application.routes.draw do
  resources :documents
  resources :staffs
  resources :stocks
  resources :stock_types
  root to: 'home#welcome'
  
  resources :commodities
  resources :commodity_types
  resources :warehouses
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
