Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :products do
      member do
        post :upload_image
      end
    end

    resources :carts, only: [:index, :show, :create, :update]
    resources :users, only: [:create, :login]
    resources :orders, only: [:create, :update, :show]
    resources :categories, only: [:index]
  end

  post '/login', to: "api/users#login"

  resources :admins
end
