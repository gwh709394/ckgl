Rails.application.routes.draw do
  resources :commodity_warehouse_relationships do
    collection do
      get 'warning'
    end
  end
  resources :documents
  resources :staffs
  resources :stocks
  resources :stock_types
  root to: 'home#welcome'
  
  resources :commodities do
    collection do
      get :barcode
    end
  end
  resources :commodity_types
  resources :warehouses
  devise_for :users
  resources :users do
    member do
      get :reset_password
    end
  end
  mount ApplicationApi => '/api'
  mount GrapeSwaggerRails::Engine => '/apidoc'
end
