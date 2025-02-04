Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :products do
      member do
        post :upload_image
        post :delete_image
      end
    end

    resources :users, only: [:create, :login] do
      collection do
        get :list_orders
      end
    end

    resources :orders, only: [:index, :create, :update, :show] do
      member do
        post :confirmar
      end
    end

    resources :carts, only: [:index, :show, :create, :update]
    resources :categories, only: [:index, :create]
  end

  post '/login', to: "api/users#login"
  get 'address/search', to: 'api/address#search'

  resources :admins
end
