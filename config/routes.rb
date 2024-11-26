Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :products
    resources :carts, only: [:show, :create]
  end
end
