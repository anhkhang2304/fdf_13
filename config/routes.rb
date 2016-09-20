Rails.application.routes.draw do
  post "/rate" => "rater#create", :as => "rate"
  root "static_pages#index"
  namespace :admin do
    root "static_pages#index"
    resources :static_pages
    resources :categories
    resources :products
    resources :users, only: [:index, :show, :destroy]
  end
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: :show
  resources :products, only: [:index, :show]
end
