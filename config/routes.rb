require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  Sidekiq::Web.use Rack::Session::Cookie, secret: Rails.application.credentials.secret_key_base

  namespace :api, defaults: { format: :json } do
    # Produtos
    resources :products do
      member do
        post :upload_image
        post :delete_image
      end
    end

    # Usúarios
    resources :users, only: [:create] do
      collection do
        get :details
        get :list_orders
      end
    end

    # Carrinhos
    resources :carts, only: [:index, :show, :create, :update] do
      member do
        post :add_cupom
      end
    end

    # Pedidos
    resources :orders, only: [:index, :create, :update, :show] do
      member do
        post :confirmar
      end
    end

    resources :admins, only: [:create]
    resources :categories, only: [:index, :create]
    resources :category_products, only: [:index]
    resources :cupoms, only: [:index, :create, :update]
    resources :colors, only: [:index, :create, :update, :destroy]
  end

  post '/login', to: "api/users#login"
  post '/admin_login', to: "api/admins#login"
  post '/reload_products', to: "api/config#reload_products"
  post '/calculate_freight', to: "api/freights#calculate"

  get 'address/search', to: 'api/address#search'
  get '/active_cart', to: 'api/users#active_cart'
  get '/active_order', to: 'api/orders#active_order'
end
