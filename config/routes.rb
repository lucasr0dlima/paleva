Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root to: "home#index"

  get "/clear_order", to: "home#clear_order"
  resources :restaurants do
    get 'search', on: :collection
  end
  resources :dishes do
    resources :portions, only: [:new, :create, :index]
    resources :taggings, only: [:new, :create]
    member do
      get 'disable'
      get 'enable'
    end
  end
  resources :beverages do
    resources :portions, only: [:new, :create, :index]
    resources :taggings, only: [:new, :create]
    member do
      get 'disable'
      get 'enable'
    end
  end
  resources :products do
    resources :portions, only: [:new, :create, :index]
  end
  resources :portions do
    get 'order', on: :member
  end

  resources :tags, only: [:new, :create]

  resources :menus do
    resources :menu_items
  end

  resources :menu_items

  resources :orders
    
  resources :permits

  # Rails.application.routes.draw do
  #   devise_for :users, controllers: {
  #     sessions: 'users/sessions'
  #   }
  # end
end
