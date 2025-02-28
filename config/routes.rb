require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  Sidekiq::Web.use Rack::Session::Cookie, secret: Rails.application.credentials.secret_key_base

  namespace :api, defaults: { format: :json } do
    resources :products do
      member do
        post :upload_image
        post :delete_image
      end
    end

    resources :users, only: [:create] do
      collection do
        get :details
        get :list_orders
      end
    end

    resources :orders, only: [:index, :create, :update, :show] do
      member do
        post :confirmar
      end
    end

    resources :carts, only: [:index, :show, :create, :update] do
      member do
        post :add_cupom
      end
    end

    resources :admins, only: [:create]
    resources :categories, only: [:index, :create]
    resources :category_products, only: [:index]
    resources :cupoms, only: [:index, :create, :update]
  end

  post '/login', to: "api/users#login"
  post '/admin_login', to: "api/admins#login"
  post '/reload_products', to: "api/config#reload_products"
  post '/calculate_freight', to: "api/freights#calculate"

  get 'address/search', to: 'api/address#search'
  get '/cart_active', to: 'api/users#cart_active'
  get '/active_order', to: 'api/orders#active_order'
end
