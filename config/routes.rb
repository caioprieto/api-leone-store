Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :products

    resources :carts, only: [:index, :show, :create, :update] do
      collection do
        get :user_carts
      end
    end

    resources :users, only: [:create]
  end

  post '/login', to: "api/users#login"

  resources :admins
end
