Rails.application.routes.draw do
  devise_for :users
  default_url_options host: "localhost", port: 3005 if Rails.env.development?

  resources :products
  resources :product_types
  resources :product_categories
  get "mypages/home"
  get "mypages/contact"
  get "mypages/about_us"
  get "mypages/product"
  get "mypages/jde"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "mypages#home"
  namespace :api do
    namespace :v1 do
      resources :product_categories
      resources :product_types
      resources :products
    end
  end
end
