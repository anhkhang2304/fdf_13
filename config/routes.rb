Rails.application.routes.draw do
  namespace :admin do
    root "static_pages#index"
    resources :static_pages
  end
end
