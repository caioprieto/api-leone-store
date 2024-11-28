Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :products
    resources :carts, only: [:index, :show, :create, :update]
    resources :users, only: [:create]
    resources :orders, only: [:create, :update, :show]
  end

  post '/login', to: "api/users#login"

  resources :admins
end
