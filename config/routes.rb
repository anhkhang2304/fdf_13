Rails.application.routes.draw do
  post "/rate" ,to: "rater#create", as: "rate"
  get "/chatwork", to: "chatwork#send_message"
  get "/feedbacks", to: "feedbacks#show"
  root "static_pages#index"
  namespace :admin do
    root "static_pages#index"
    resources :static_pages
    resources :categories
    resources :products
    resources :orders
    resources :users, only: [:index, :show, :destroy]
  end
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: :show
  resources :products, only: [:index, :show]
  resources :orders
  resources :detail_orders, only: [:create]
  resources :comments, only: :create
  resources :feedbacks, only: :create
  resources :detail_orders, only: [:create, :destroy, :update]
end
