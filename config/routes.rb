Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :products do
      member do
        post :upload_image
        post :delete_image
      end
    end

    resources :carts, only: [:index, :show, :create, :update]
    resources :users, only: [:create, :login]
    resources :categories, only: [:index]

    resources :orders, only: [:index, :create, :update, :show] do
      member do
        post :confirmar
      end
    end
  end

  post '/login', to: "api/users#login"
  get 'address/search', to: 'api/address#search'

  resources :admins
end
