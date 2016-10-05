class API::V1::TestsAPI < Grape::API
  version "v1", using: :header
  format :json

  helpers do
    def current_user
    @current_user ||= User.authorize!(env)
  end

  def authenticate!
    error!("401 Unauthorized", 401) unless current_user
    end
  en

  resources :tests do
    get do
      User.all
    end
  end
end
